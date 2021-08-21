%% Problem 5-3a of Birdsall and Langdon

addpath('ES1PicCodes')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=64;
nt=1e4;
dt=1e-2;

% Define initial plasma and magentic field
B0=0;
species=PlasmaSetup(1,L);

% Run pic solver
ani=[1 3e2]; % Animate? [x y z] => x=0 for don't animate, 1 for animate; y=frame speed (skip); z=plot force on species z, leave empty for no force plot
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
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
hold off


% Repeat with no ions, relying on uniform neutralizing background (see
% QtoGrid.m)
species=PlasmaSetup(3,L);

% Run pic solver
ani=[1 1e2]; % Animate? [x y z] => x=0 for don't animate, 1 for animate; y=frame speed (skip); z=plot force on species z, leave empty for no force plot
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
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
hold off