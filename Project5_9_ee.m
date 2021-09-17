%% Project 5-9 e-e Stream of Birdsall and Langdon

addpath('ES1PicSolver')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=32;
T=80;
dt=1e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

N=4096;

xmode=1;
x11=1.1e-3;
x12=1.1e-3;
vmode=0;
v1=0;
theta=0;
[xe1,v01]=init(N,L,xmode,x11,0,1,vmode,-v1,theta);
[xe2,v02]=init(N,L,xmode,x12,0,-1,vmode,v1,theta);

electron1=Species(N,L);
electron1.qm=-1;
electron1.vx0=v01;
electron1.x0=xe1;

electron2=Species(N,L);
electron2.qm=-1;
electron2.vx0=v02;
electron2.x0=xe2;

species=[electron1 electron2];

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
xe1=x{1};
xe2=x{2};
vxe1=vx{1};
vxe2=vx{2};

% Animate results
skip=5;
figure
for i=1:skip:length(t)
    Titl=sprintf('t = %2.1f',t(i));
    plot(xe1(:,i),vxe1(:,i),'.',xe2(:,i),vxe2(:,i),'.')
    title(Titl)
    xlabel('position')
    ylabel('vx')
    xlim([0 L])
    ylim([-2 2])
    pause(0.1)
end

% Plot results like in text
times=[16 17 18 34 60];
tind=zeros(1,length(times));
for i=1:length(times)
    [~,I]=min(abs(t-times(i)));
    tind(i)=I;
end
figure
for i=1:length(tind)
    Titl=sprintf('t = %2.1f',t(tind(i)));
    subplot((length(tind)+1)/2,2,i)
    plot(xe1(:,tind(i)),vxe1(:,tind(i)),'k.',xe2(:,tind(i)),vxe2(:,tind(i)),'k.')
    xlim([0 L])
    title(Titl)
    xlabel('position')
    ylabel('vx')
end
subplot((length(tind)+1)/2,2,i+1)
plot(t,DE,t,THE,t,ESE)
axis([0 30 0 DE(1)*1.05])
legend('D','T','F','location','west')
xlabel('time')
ylabel('Energy')