%% Project 5-9 e-p Stream of Birdsall and Langdon

addpath('ES1PicCodes')
clear

% Define spacial and temporal grid parameters
L=2*pi;
nx=64; % I have found that the stability depends on the # of grid cells
T=30;
dt=1e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

Ne=120;
Ni=Ne;

xmode=0;
x1=0;
vmode=1/2;
v1=0.01;
theta=10*pi/L;
[xe,v0e]=init(Ne,L,xmode,x1,0,1,vmode,v1,theta);
[xi,v0i]=init(Ni,L,xmode,x1,0,-1,vmode,-v1,theta);

ion=Species;
ion.N=Ni;
ion.vx0=v0i;
ion.vy0=0*ones(1,Ni);
ion.x0=xi;

electron=Species;
electron.N=Ne;
electron.q=-1;
electron.vx0=v0e;
electron.vy0=0*ones(1,Ne);
electron.x0=xe;

species=[ion electron];

% Run pic solver
ani=[0 0]; % Animate? [x y] => x=0 for don't animate, 1 for animate; y=frame speed (skip)
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t,xi,xe,vxi,vxe]=pic(species,nx,nt,dt,L,B0,method,ani);

% Animate results
skip=5;
figure
for i=1:skip:length(t)
    Titl=sprintf('t = %2.1f',t(i));
    plot(xi(:,i),vxi(:,i),'.',xe(:,i),vxe(:,i),'.')
    title(Titl)
    xlabel('position')
    ylabel('vx')
    xlim([0 L])
    pause(0.1)
end

% Plot results
times=[1 7 9 9.2 9.5 14];
for i=1:length(times)
    tlist=t(t<=times(i));
    tnear=tlist(end);
    tind(i)=find(t==tnear);
end
figure
for i=1:length(tind)
    Titl=sprintf('t = %2.1f',t(tind(i)));
    subplot(length(tind)/2,2,i)
    plot(xi(:,tind(i)),vxi(:,tind(i)),'.',xe(:,tind(i)),vxe(:,tind(i)),'.')
    title(Titl)
    xlabel('position')
    ylabel('vx')
end