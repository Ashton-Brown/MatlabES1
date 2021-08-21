%% Problem 5-3a of Birdsall and Langdon

addpath('ES1PicCodes')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=101;
nt=1e4;
dt=1e-2;

% Define initial plasma and magentic field
B0=0;
species=PlasmaSetup(1,L);

% Run pic solver
ani=[1 1e2]; % Animate? [x y z] => x=0 for don't animate, 1 for animate; y=frame speed (skip); z=plot force on species z, leave empty for no force plot
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t,~,xe]=pic(species,nx,nt,dt,L,B0,method,ani);

% Plot results
figure
plot(t,xe)
xlabel('time')
ylabel('electron positions')