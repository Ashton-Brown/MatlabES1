%% Problem 5-3c of Birdsall and Langdon

addpath('ES1PicSolver')
clear; close all;

% Velocity modulation paramter
v1=0.120;

% Define spacial and temporal grid parameters
L=2*pi;
nx=32;
T=40;
dt=1e-2;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

N=50;
electron=Species(N,L);
electron.qm=-1;
electron.vx0=v1*sin(2*pi/L*electron.x0);

species=electron;

% Run pic solver
ani=0;
method=[1 0];
[t,x]=pic(species,nx,nt,dt,L,B0,method,ani);

% Plot results
figure
plot(t,x)
xlabel('time')
ylabel('positions')
TITLE=sprintf('v1 = %1.3f',v1);
title(TITLE)

% Check against answer in text
fprintf('\nCrossing should occur around v1 = %1.3f\n',L/N*electron.wp);