function [t_out,x_out,vx_out,vy_out,ESE,KE,DE,ThE] = pic(species,nx,nt,dt,L,B0,method,ani)
% This function is the 'main' of this MatlabES1 particle-in-cell (pic)
% solver.  It simulates plamsa behavior for a 1D periodic system.

%% INPUTS
% species = A list of species that make up the plasma, all of class Species
% nx = The number of grid points and grid cells.
% nt = The total number of time steps.
% dt = The time step size.
% L = The system length.
% B0 = The applied magnetic field.
% method =  The first element specifies which weighting method to use: 0 for
%           nearest grid point, and 1 for cloud in cell.  The second
%           element specifies which method to use for solving Poisson's
%           equation for phi: 0 for finite difference method using MATLAB's
%           linear algebra solver '\', and 1 for the fast Fourier transform 
% ani = 0 for don't animate, 1 for animate.  When 1, ani can have a second
%       element that specifies the frame speed, and a third element that
%       specifies for which species to plot the forces.  Examples: ani=0
%       does not animate, ani=[1 2] animates with double speed, and 
%       ani = [1 10 2] animates with 10x speed and plots the forces on the
%       second species in the input 'species'.

%% OUTPUTS
% t_out = An array of the time steps.
% x_out =   A matrix of the positions of all particles at each time step.
%           This matrix must be unpacked to get positions by species.
% vx_out =  A matrix of the x-velocities of all particles at each time step.
%           This matrix must be unpacked to get velocities by species.
% vy_out =  A matrix of the y-velocities of all particles at each time step.
%           This matrix must be unpacked to get velocities by species.
% ESE = An array of the electrostatic or field energy at each time step.
% KE = A matrix of the kinetic energy of each species at each time step.
% DE = An array of the drift energy at each time step.
% ThE = An array of the thermal energy at each time step.

%% Load species into easy variable names
n=1;
for sp=1:length(species)
    N(sp)=species(sp).N;
    wp(sp)=species(sp).wp;
    qm(sp)=species(sp).qm;
    x(n:(n-1+N(sp)))=species(sp).x0;
    vx(n:(n-1+N(sp)))=species(sp).vx0;
    vy(n:(n-1+N(sp)))=species(sp).vy0;
    move_yn{sp}=species(sp).move_yn;
    n=n+N(sp);
end
m=wp.^2*L./(qm.^2.*N); % wp^2 = q^2*N/(m*L) = qm^2*m*N/L
q=qm.*m;
wc=(q*B0)./m;

%% Move velocity half-step back
t=0;
dx=L/nx;
rho=get_rho(x,q,N,nx,L,method(1));
phi=calc_phi(rho,dx,method(2));
E0=calc_E(phi,dx);
E=get_E(E0,x,N,nx,L,method(1));
[vx,vy]=rotate(vx,vy,N,wc,-dt);
vx=accel(vx,N,E,qm,-dt,move_yn);


%% Simulate over time
if ani(1)==1
    rholimits=[0 0]; Vlimits=[0 0]; Elimits=[0 0];
    myPlot
    if length(ani)>1; skip=ani(2); else skip=1; end
end
for i=1:nt
    t=t+dt;
    
    % Update velocity
    vx=accel(vx,N,E,qm,dt,move_yn);
    [vx,vy]=rotate(vx,vy,N,wc,dt);
    vx=accel(vx,N,E,qm,dt,move_yn);
    
    % Update position
    x=move(x,vx,N,dt,L);
    
    % Save output quantities
    t_out(i)=t;
    x_out(:,i)=x;
    vx_out(:,i)=vx;
    vy_out(:,i)=vy;
    [ESe,Ke,De,The]=energies(N,dx,rho,phi,vx,vy,m);
    ESE(i)=ESe;
    for sp=1:length(N); KE(sp,i)=Ke(sp); end
    DE(i)=De;
    ThE(i)=The;
    
    % Update field
    rho=get_rho(x,q,N,nx,L,method(1));
    phi=calc_phi(rho,dx,method(2));
    E0=calc_E(phi,dx);
    E=get_E(E0,x,N,nx,L,method(1));
    
    %Plot animation if animation is on (if ani(1)==1)
    if ani(1)==1; if mod(i,skip)==0; myPlot; end; end
end

end