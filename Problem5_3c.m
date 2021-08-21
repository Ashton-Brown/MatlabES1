%% Problem 5-3c of Birdsall and Langdon

addpath('ES1PicCodes')
clear; close all;
% Velocity modulation paramter
v1=1.11;

% Define spacial and temporal grid parameters
L=2*pi;
nx=64;
nt=3e3;
dt=1e-2;

% Define initial plasma and magentic field
B0=0;

Nelec=20;

Nion=2e3;
ion=Species;
ion.N=Nion;
ion.q=Nelec/Nion;
ion.vx0=0*ones(1,Nion);
ion.vy0=0*ones(1,Nion);
ion.x0=linspace(0+L/(2*Nion),L-L/(2*Nion),Nion);
ion.move_yn='n';

electron=Species;
x=linspace(0+L/(2*Nelec),L-L/(2*Nelec),Nelec);
electron.N=Nelec;
electron.q=-1;
electron.vx0=v1*sin(2*pi/L*x);
electron.vy0=0*ones(1,Nelec);
electron.x0=x;%linspace(0+L/(2*Nelec),L-L/(2*Nelec),Nelec);

species=[ion electron];

% Run pic solver
ani=[1 10]; % Animate? [x y] => x=0 for don't animate, 1 for animate; y=frame speed (skip)
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t,~,xe]=pic(species,nx,nt,dt,L,B0,method,ani);
figure
plot(t,xe)