%% Project 5-12 Beam-Plasma Instability of Birdsall and Langdon

addpath('ES1PicSolver')
clear;close all;

% Primary parameters for this project
R=1e-3;
v0=1;

% Define spacial and temporal grid parameters
L=2*pi;
nx=64;
T=300;
dt=2e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

Np=nx;
Nb=512;

xmode=1;
x1=1e-3;
vmode=1;
v1=0;
thetap=0;
thetab=0;
[xp,v0p]=init(Np,L,xmode,0,0,0,vmode,0,thetap);
[xb,v0b]=init(Nb,L,xmode,x1,0,v0,vmode,v1,thetab);

plasma=Species(Np,L);
plasma.qm=1e-5;
plasma.vx0=v0p;
plasma.x0=xp;

beam=Species(Nb,L);
beam.wp=sqrt(R);
beam.vx0=v0b;
beam.x0=xb;

species=[plasma beam];

% Run pic solver
ani=0;
method=[1 0];
[t,x_out,vx_out]=pic(species,nx,nt,dt,L,B0,method,ani);
n=1;
for sp=1:length(species)
    N=species(sp).N;
    x{sp}=x_out(n:(n-1+N),:);
    vx{sp}=vx_out(n:(n-1+N),:);
    n=n+N;
end
xp=x{1};
xb=x{2};
vxp=vx{1};
vxb=vx{2};

% Animate results
skip=40;
figure
for i=1:skip:length(t)
    Titl=sprintf('t = %2.1f',t(i));
    plot(xp(:,i),vxp(:,i),'.',xb(:,i),vxb(:,i),'.')
    title(Titl)
    xlabel('position')
    ylabel('vx')
    axis([0 L -0.5 1.5])
    pause(0.1)
end

% Plot results
times=[146 173 202 230 258 286];
tind=zeros(1,length(times));
for i=1:length(times)
    [~,I]=min(abs(t-times(i)));
    tind(i)=I;
end
figure
for i=1:length(tind)
    Titl=sprintf('t = %2.1f',t(tind(i)));
    subplot(length(tind)/2,2,i)
    plot(xp(:,tind(i)),vxp(:,tind(i)),'k.',xb(:,tind(i)),vxb(:,tind(i)),'k.')
    title(Titl)
    xlabel('position')
    ylabel('vx')
end