%% Project 5-9 e-p Stream of Birdsall and Langdon

addpath('ES1PicSolver')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=32;
T=60;
dt=1e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

N=4096;

xmode=1;
x1=1.1e-3;
vmode=0;
v1=0;
thetae=0;
thetai=0;
[xe,v0e]=init(N,L,xmode,x1,0,1,vmode,v1,thetae);
[xi,v0i]=init(N,L,xmode,x1,0,-1,vmode,-v1,thetai);

ion=Species(N,L);
ion.vx0=v0i;
ion.x0=xi;

electron=Species(N,L);
electron.qm=-1;
electron.vx0=v0e;
electron.x0=xe;

species=[ion electron];

% Run pic solver
ani=0;
method=[1 0];
[t,x_out,vx_out,~,ESE,KE,DE,THE]=pic(species,nx,nt,dt,L,B0,method,ani);
n=1;
for sp=1:length(species)
    N=species(sp).N;
    x{sp}=x_out(n:(n-1+N),:);
    vx{sp}=vx_out(n:(n-1+N),:);
    n=n+N;
end
xi=x{1};
xe=x{2};
vxi=vx{1};
vxe=vx{2};

% Animate results
skip=10;
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
times=[14 15 16 33];
tind=zeros(1,length(times));
for i=1:length(times)
    [~,I]=min(abs(t-times(i)));
    tind(i)=I;
end
figure
for i=1:length(tind)
    Titl=sprintf('t = %2.1f',t(tind(i)));
    subplot(length(tind)/2+1,2,i)
    plot(xi(:,tind(i)),vxi(:,tind(i)),'k.',xe(:,tind(i)),vxe(:,tind(i)),'k.')
    xlim([0 L])
    title(Titl)
    xlabel('position')
    ylabel('vx')
end
subplot(length(tind)/2+1,2,i+1)
semilogy(t,ESE)
legend('F')
xlabel('time')
ylabel('Energy')
axis([0 30 1e-6 1.15])
subplot(length(tind)/2+1,2,i+2)
plot(t,DE,t,THE,t,ESE)
legend('D','T','F')
xlim([0 30])
xlabel('time')
ylabel('Energy')