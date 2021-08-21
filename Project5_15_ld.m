%% Project 5-15 Landau Damping of Birdsall and Langdon

addpath('ES1PicCodes')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=256;
T=20;
dt=1e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

qc=-1;
qh=-1;
qm=-0.1;

Nc=nx;
Nh=2^14;
Nm=1020;
fac=1;
Ni=-fac*(qh*Nh+qc*Nc+qm*Nm);

xi=linspace(0+L/(2*Ni),L-L/(2*Ni),Ni);
xh=linspace(0+L/(2*Nh),L-L/(2*Nh),Nh);
xc=linspace(0+L/(2*Nc),L-L/(2*Nc),Nc);
xm=linspace(0+L/(2*Nm),L-L/(2*Nm),Nm);

ion=Species;
ion.N=Ni;
ion.q=1/fac;
ion.vx0=0*ones(1,Ni);
ion.vy0=0*ones(1,Ni);
ion.x0=xi;
ion.move_yn='n';

ehot=Species;
ehot.N=Nh;
ehot.q=qh;
ehot.m=1;
ehot.vx0=0*ones(1,Nh);
ehot.vy0=0*ones(1,Nh);
ehot.x0=xh;

ecold=Species;
ecold.N=Nc;
ecold.q=qc;
ecold.m=100;
ecold.vx0=0*ones(1,Nc);
ecold.vy0=0*ones(1,Nc);
ecold.x0=xc;

marker=Species;
marker.N=Nm;
marker.q=qm;
marker.m=-qm;
vmode=3;
v1=0.01;
theta=0;
for i=1:Nm
    switch mod(i-1+3,3)
        case 0
            v0(1,i)=0.8+v1*cos(2*pi*vmode*xm(i)/L+theta);
        case 1
            v0(1,i)=0.9+v1*cos(2*pi*vmode*xm(i)/L+theta);
        case 2
            v0(1,i)=1.0+v1*cos(2*pi*vmode*xm(i)/L+theta);
    end
end
marker.vx0=v0;
marker.vy0=0*ones(1,Nm);
marker.x0=xm;

species=[marker ehot ecold ion];

% Run pic solver
ani=[0 0]; % Animate? [x y] => x=0 for don't animate, 1 for animate; y=frame speed (skip)
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t,xm,xh,vxm,vxh]=pic(species,nx,nt,dt,L,B0,method,ani);

% Animate results
skip=2;
figure
for i=1:skip:length(t)
    Titl=sprintf('t = %2.1f',t(i));
    plot(xm(:,i),vxm(:,i),'.')
    title(Titl)
    xlabel('position')
    ylabel('vx')
    xlim([0 L])
    pause(0.1)
end

% Plot results
% times=[0 12 14 15 16 17];
% for i=1:length(times)
%     tlist=t(t<=times(i));
%     tnear=tlist(end);
%     tind(i)=find(t==tnear);
% end
% figure
% for i=1:length(tind)
%     Titl=sprintf('t = %2.1f',t(tind(i)));
%     subplot(length(tind)/2,2,i)
%     plot(xm(:,tind(i)),vxm(:,tind(i)),'.')
%     title(Titl)
%     xlabel('position')
%     ylabel('vx')
% end