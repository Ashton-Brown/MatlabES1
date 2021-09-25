%% Project 5-15 Landau Damping of Birdsall and Langdon
% See this issue: https://github.com/Ashton-Brown/MatlabES1/issues/2#issue-998833697

addpath('ES1PicSolver')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=256;
T=100;
dt=1e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

Nh=2^14;
Nc=nx;
Nm=1020;

% Quiet start - haven't worked this out yet
v1h=0;
v2h=0;
[~,vh0]=init(Nh,L,0,0,0,v1h,1,v2h,0);

ehot=Species(Nh,L);
ehot.qm=1;
ehot.wp=0.383;
ehot.vx0=vh0;

v1c=2.5e-4;
[~,vxc]=init(Nc,L,0,0,0,0,1,v1c,0);
ecold=Species(Nc,L);
ecold.qm=0.01;
ecold.wp=0.924;
ecold.vx0=vxc;

marker=Species(Nm,L);
marker.qm=-1;
marker.wp=10^-10;
vmode=1;
v1m=0;
theta=0;
for i=1:Nm
    switch mod(i-1+3,3)
        case 0
            v0(1,i)=0.8+v1m*cos(2*pi*vmode*marker.x0(i)/L+theta);
        case 1
            v0(1,i)=0.9+v1m*cos(2*pi*vmode*marker.x0(i)/L+theta);
        case 2
            v0(1,i)=1.0+v1m*cos(2*pi*vmode*marker.x0(i)/L+theta);
    end
end
marker.vx0=v0;

species=[marker ehot ecold];

% Run pic solver
ani=0;
method=[1 0];
[t,x_out,vx_out,~,ESE]=pic(species,nx,nt,dt,L,B0,method,ani);
n=1;
for sp=1:length(species)
    N=species(sp).N;
    x{sp}=x_out(n:(n-1+N),:);
    vx{sp}=vx_out(n:(n-1+N),:);
    n=n+N;
end
xm=x{1};
xh=x{2};
xc=x{3};
vxm=vx{1};
vxh=vx{2};
vxc=vx{3};

% Animate results
skip=10;
figure
for i=1:skip:length(t)
    Titl=sprintf('t = %2.1f',t(i));
    plot(xm(:,i),vxm(:,i),'.')
    title(Titl)
    xlabel('position')
    ylabel('vx')
    axis([0 L 0.7 1.3])
    pause(0.1)
end

% Plot results
times=[2 16 30 40 90];
tind=zeros(1,length(times));
for i=1:length(times)
    [~,I]=min(abs(t-times(i)));
    tind(i)=I;
end
figure
for i=1:length(tind)
    Titl=sprintf('t = %2.1f',t(tind(i)));
    subplot((length(tind)+1)/2,2,i)
    plot([xm(:,tind(i)) (xm(:,tind(i))+L)],[vxm(:,tind(i)) vxm(:,tind(i))],'k.')
    xlim([0 2*L])
    title(Titl)
    xlabel('position')
    ylabel('vx')
end
subplot((length(tind)+1)/2,2,i+1)
semilogy(t,ESE)
axis([0 100 1e-7 1e-3])
legend('F')
xlabel('time')
ylabel('Energy')