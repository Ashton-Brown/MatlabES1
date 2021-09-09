%% Problem 5-3a of Birdsall and Langdon

addpath('ES1PicSolver')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=256;
T=40;
dt=1e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;
species=PlasmaSetup(1,L);

% Run pic solver
ani=[1 7 2];
method=[1 0];
[t,x_out]=pic(species,nx,nt,dt,L,B0,method,ani);
n=1;
for sp=1:length(species)
    N=species(sp).N;
    x{sp}=x_out(n:(n-1+N),:);
    n=n+N;
end

% Plot results
figure
subplot(2,1,1)
title('equal # of electrons and stationary ions')
dxdt=diff(x{sp},1,2)/dt;
hold on
for sp=1:length(species)
    plot(t(2:end),dxdt)
end
xlabel('time')
ylabel('dx/dt')
hold off
subplot(2,1,2)
dvdt=diff(dxdt,1,2)/dt;
plot(t(3:end),dvdt)
xlabel('time')
ylabel('dv/dt')
hold off


% Repeat with no ions, relying on uniform neutralizing background
species=PlasmaSetup(3,L);

% Run pic solver
ani=[1 7 1];
method=[1 0];
[t,x_out,vx_out]=pic(species,nx,nt,dt,L,B0,method,ani);
n=1;
for sp=1:length(species)
    N=species(sp).N;
    x{sp}=x_out(n:(n-1+N),:);
    vx{sp}=vx_out(n:(n-1+N),:);
    n=n+N;
end

% Plot results
figure
subplot(2,1,1)
title('electrons and uniform background')
dxdt=diff(x{sp},1,2)/dt;
hold on
for sp=1:length(species)
    plot(t(2:end),dxdt)
end
xlabel('time')
ylabel('dx/dt')
hold off
subplot(2,1,2)
dvdt=diff(dxdt,1,2)/dt;
plot(t(3:end),dvdt)
xlabel('time')
ylabel('dv/dt')
hold off