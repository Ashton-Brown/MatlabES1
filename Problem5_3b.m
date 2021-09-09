%% Problem 5-3b of Birdsall and Langdon

addpath('ES1PicSolver')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=64;
nt=1e4;
dt=1e-2;

% Define initial plasma and magentic field
B0=0;
species=PlasmaSetup(4,L);

% Run pic solver
ani=[1 1e2 2];
method=[1 0];
[t,x_all]=pic(species,nx,nt,dt,L,B0,method,ani);
n=1;
for sp=1:length(species)
    N=species(sp).N;
    x{sp}=x_all(n:(n-1+N),:);
    n=n+N;
end

% Plot results
figure
plot(t,x{2})
xlabel('time')
ylabel('positions')
title('Large # of neutralizing, stationary ions')
ylim([0 L])

% Repeat with no ions, relying on uniform neutralizing background
species=PlasmaSetup(3,L);

% Run pic solver
ani=[1 1e2 1];
method=[1 0];
[t,x_all]=pic(species,nx,nt,dt,L,B0,method,ani);
n=1;
for sp=1:length(species)
    N=species(sp).N;
    x{sp}=x_all(n:(n-1+N),:);
    n=n+N;
end

% Plot results
figure
hold on
for sp=1:length(species)
    plot(t,x{sp})
end
xlabel('time')
ylabel('position')
title('Uniform neutralizing background')
hold off
ylim([0 L])