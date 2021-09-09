%% Check calculated energies
% This script simulates oscillating electrons in a uniform neutralizing
% background, and outputs the energies over time.  The basic check is to
% observe a relatively constant total energy.

addpath('ES1PicSolver')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=64;
T=50;
dt=1e-2;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

N=10;
offset=L/(N*5);
altdx=zeros(1,N);

electron=Species(N,L);
electron.qm=-1;
for i=1:N; altdx(i)=(-1)^i*offset; end
electron.x0=electron.x0+altdx;

species=electron;

% Run pic solver
ani=[1 1e2]; % Animate? [x y] => x=0 for don't animate, 1 for animate; y=frame speed (skip)
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t,~,~,~,ESE,KE,DE,THE]=pic(species,nx,nt,dt,L,B0,method,ani);

% Plot results
figure
plot(t,DE,t,THE,t,KE,t,ESE,t,ESE+KE)
xlabel('time')
ylabel('Energy')
legend('D','Th','K','F','K+F')
xlim([0 T])