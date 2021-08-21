%% Problem 5-3b of Birdsall and Langdon

addpath('ES1PicCodes')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=64;
nt=1e4;
dt=1e-2;

% Define initial plasma and magentic field
B0=0;

fac=100;
Ne=4;
Ni=fac*Ne;
xe=linspace(0+L/(2*Ne),L-L/(2*Ne),Ne);
xi=linspace(0+L/(2*Ni),L-L/(2*Ni),Ni);

ion=Species;
ion.N=Ni;
ion.q=1/fac;
ion.vx0=0*ones(1,Ni);
ion.vy0=0*ones(1,Ni);
ion.x0=xi;
ion.move_yn='n';

electron=Species;
electron.N=Ne;
electron.q=-1;
for i=1:Ne; alt(i)=(-1)^i; end
electron.vx0=1e-1*alt.*ones(1,Ne);
electron.vy0=0*ones(1,Ne);
electron.x0=xe;

species=[ion electron];

% Run pic solver
ani=[1 1e2 2]; % Animate? [x y z] => x=0 (don't), 1 (do); y=frame speed (skip); z=plot forces on species z
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t,~,xe]=pic(species,nx,nt,dt,L,B0,method,ani);

% Plot results
figure
plot(t,xe)
xlabel('time')
ylabel('electron positions')