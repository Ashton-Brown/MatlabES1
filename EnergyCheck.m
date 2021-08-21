%% Script for troubleshooting energy cacls

addpath('ES1PicCodes')
clear; close all;

% Define spacial and temporal grid parameters
L=30;
nx=L*10;
nt=1e4;
dt=1e-2;

% Define initial plasma and magentic field
B0=0;

N=20;
x=linspace(0+L/(2*N),L-L/(2*N),N);
dx=L/(N*10);

ion=Species;
ion.N=N;
ion.q=1;
ion.vx0=0*ones(1,N);
ion.vy0=0*ones(1,N);
ion.x0=x;
ion.move_yn='n';

electron=Species;
electron.N=N;
electron.q=-1;
electron.vx0=0*ones(1,N);
electron.vy0=0*ones(1,N);
for i=1:N; alt(i)=(-1)^i; end
electron.x0=x+alt*dx;

species=[ion electron];

% Run pic solver
ani=[0 1e2]; % Animate? [x y] => x=0 for don't animate, 1 for animate; y=frame speed (skip)
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t,~,~,vxi,vxe,ESE,KE,DE,THE]=pic(species,nx,nt,dt,L,B0,method,ani);

% Plot results
figure
subplot(2,3,1)
plot(t,ESE)
ylabel('Field Energy')
subplot(2,3,2)
plot(t,KE)
ylabel('Kinetic Energies')
subplot(2,3,3)
plot(t,DE)
ylabel('Drift Energy')
subplot(2,3,4)
plot(t,THE)
ylabel('Thermal Energy')
subplot(2,3,5)
plot(t,ESE+sum(KE,1))
ylabel('Total Energy')

fprintf('\n%2.2f\n',max(sum(KE,1))/max(ESE))