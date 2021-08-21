function [t_out,x_out,vx_out,vy_out,ESE,KE,DE,THE] = pic(species,nx,nt,dt,L,B0,method,ani)
% This particle-in-cell (pic) function simulates plamsa behavior for a 1D
% system.  The solver uses nearest-grid-point for cell weighting and the
% Ax=b linear algebra solver for finding the voltage on the grid.  Periodic
% boundary conditions are implemented.


% Load species into easy variables
n=1;
for sp=1:length(species)
    q(sp)=species(sp).q;
    m(sp)=species(sp).m;
    N(sp)=species(sp).N;
    x(n:(n-1+N(sp)))=species(sp).x0;
    vx(n:(n-1+N(sp)))=species(sp).vx0;
    vy(n:(n-1+N(sp)))=species(sp).vy0;
    move_yn{sp}=species(sp).move_yn;
    n=n+N(sp);
end
qm=q./m;
wc=(q*B0)./m;

% Move velocity half-step back
t=0;
dx=L/(nx-1);
rho=QtoGrid(x,q,N,nx,L,method(1));
switch method(2)
    case 0
        phi=poisson_FD(rho,dx);
    case 1
        phi=poisson_FFT(rho,L,dx);
end
E0=calc_E(phi,dx);
E=interpE(E0,x,N,nx,L,method(1));
[vx,vy]=rotate(vx,vy,N,-wc,dt);
vx=accel(vx,N,E,-qm,dt,move_yn);

if ani(1)==1; myPlot; end
skip=ani(2);
% Iterate over time
for i=1:nt
    t=t+dt;
    % Update velocity
    vx=accel(vx,N,E,qm,dt,move_yn);
    [vx,vy]=rotate(vx,vy,N,wc,dt);
    vx=accel(vx,N,E,qm,dt,move_yn);
    
    % Update position
    x=move(x,vx,N,dt,L);
    
    % Save quantities
    t_out(i)=t;
    x_out(:,i)=x;
    vx_out(:,i)=vx;
    vy_out(:,i)=vy;
    [ESe,Ke,De,THe]=energies(N,dx,E0,vx,vy,m);
    ESE(i)=ESe;
    for sp=1:length(N); KE(sp,i)=Ke(sp); end
    DE(i)=De;
    THE(i)=THe;
    
    if ani(1)==1; if mod(i,skip)==0; myPlot; end; end
    
    % Update field
    rho=QtoGrid(x,q,N,nx,L,method(1));
    switch method(2)
        case 0
            phi=poisson_FD(rho,dx);
        case 1
            phi=poisson_FFT(rho,L,dx);
    end
    E0=calc_E(phi,dx);
    E=interpE(E0,x,N,nx,L,method(1));
end

end