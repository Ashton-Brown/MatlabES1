%% Check plasma frequency
% This script checks the oscillating frequency of electrons in a
% neutralizing background.  See 5-3 of Birdsall and Langdon.

clear;close all;
addpath('ES1PicSolver')

% Define spacial and temporal grid parameters
L=2*pi;
nx=32;
T=10;
dt=1e-2;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

N=2;
wp1=pi/2;
electron=Species(N,L);
electron.qm=-1;
electron.wp=wp1;
electron.x0=electron.x0+[-L/N/3 +L/N/3]; % Add offset to even distribution

species=electron;

% Run pic solver
ani=[1 15 1];
method=[1 0];
[t1,x1,vx1]=pic(species,nx,nt,dt,L,B0,method,ani);

% Change wp to see if the simulation follows
wp2=2*pi;
electron.wp=wp2; 
species=electron;
[t2,x2,vx2]=pic(species,nx,nt,dt,L,B0,method,ani);

% Change grid to see how frequency changes (don't think it should)
nx=nx*4;
[t3,x3,vx3]=pic(species,nx,nt,dt,L,B0,method,ani);

% Plot traces to compare and check periods
figure
subplot(3,1,1)
plot(t1,x1)
Ylabel1=sprintf('positions (wp=%1.2f)',wp1);
ylabel(Ylabel1)
subplot(3,1,2)
plot(t2,x2)
Ylabel2=sprintf('positions (wp=%1.2f)',wp2);
ylabel(Ylabel2)
subplot(3,1,3)
plot(t3,x3)
xlabel('time')
ylabel(Ylabel2)


fprintf('\nThe plasma frequency should be %1.3f (case 1) and %1.3f (case 2), or a period of %2.2f and %2.2f.\n\n',wp1,wp2,2*pi/wp1,2*pi/wp2)