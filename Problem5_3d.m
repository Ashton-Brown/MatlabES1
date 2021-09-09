%% Problem 5-3d of Birdsall and Langdon

addpath('ES1PicSolver')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=64;
T=30;
dt=1e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

N=2; % Try N=1, N=2, and N=3...seems you need at least N=2, and even N
electron=Species(N,L);
electron.qm=-1;
v0=zeros(1,N);
for i=1:N; v0(i)=(-1)^i; end % Toggle this between positive and negative 1, to get answer to problem...seems you need alternating phases to get oscillations.
electron.vx0=1/N*v0;

species=electron;

% Run pic solver
ani=[1 1e1 1];
method=[1 0];
[t,x]=pic(species,nx,nt,dt,L,B0,method,ani);

% Plot results
figure
plot(t,x)
xlabel('time')
ylabel('electron positions')