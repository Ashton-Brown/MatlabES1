%% Check plasma frequency
% Check the osciallating frequency of two electrons in a positive uniform
% background.  The frequency should be w^2=1/eps*|q/m|_e*(n0*q)_i.  See 5-3
% of Birdsall and Langdon.

addpath('ES1PicCodes')
% Define spacial and temporal grid parameters
L=5;
nx=31;
nt=1e4;
dt=1e-2;

% Define initial plasma and magentic field
B0=0;

Nion=1e2;
ion=Species;
ion.N=Nion;
ion.q=2/Nion;
ion.vx0=0*ones(1,Nion);
ion.vy0=0*ones(1,Nion);
ion.x0=linspace(0+L/(2*Nion),L-L/(2*Nion),Nion);
ion.move_yn='n';

electron=Species;
Nelec=2;
electron.N=Nelec;
electron.q=-1;
electron.m=1;
electron.vx0=0*ones(1,Nelec);
electron.vy0=0*ones(1,Nelec);
electron.x0=[2 3];%linspace(0+L/(2*Nelec),L-L/(2*Nelec),Nelec);

species=[ion electron];

% Run pic solver
ani=1; % Display the animation? 0 for no and 1 for yes.
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t1,x1,vx1]=pic(species,nx,nt,dt,L,B0,method,ani);
electron.m=4; % Change mass to see how frequency changes with mass
species=[ion electron];
[t2,x2,vx2]=pic(species,nx,nt,dt,L,B0,method,ani);

% Plot traces and compare
figure
subplot(2,1,1)
plot(t1,x1)
ylabel('positions (m=1)')
subplot(2,1,2)
plot(t2,x2)
xlabel('time')
ylabel('positions (m=4)')