%% Project 5-12 Beam-Plasma Instability of Birdsall and Langdon

addpath('ES1PicCodes')
clear;close all;

% Project parameters
R=450;
v0=1;
wpp=1;
wpb=sqrt(R);
qp=-1;
qb=-1;
Np=64*3;
Nb=512*3;

% Define spacial and temporal grid parameters
L=2*pi;
nx=64*3;
T=100;
dt=1e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

fac=10;
qi=1/fac;
Ni=-fac*(qp*Np+qb*Nb);
Qtot=Ni*qi+Np*qp+Nb*qb;
xi=linspace(0+L/(2*Ni),L-L/(2*Ni),Ni);
xb=linspace(0+L/(2*Nb),L-L/(2*Nb),Nb);
xp=linspace(0+L/(2*Np),L-L/(2*Np),Np);

ion=Species;
ion.N=Ni;
ion.q=qi;
ion.vx0=0*ones(1,Ni);
ion.vy0=0*ones(1,Ni);
ion.x0=xi;
ion.move_yn='n';

plasma=Species;
plasma.N=Np;
plasma.q=qp;
plasma.m=qp^2*Np/(wpp^2*L);
plasma.vx0=0*ones(1,Np);
plasma.vy0=0*ones(1,Np);
plasma.x0=xp;
plasma.move_yn='y';

beam=Species;
beam.N=Nb;
beam.q=-1;
beam.m=qb^2*Nb/(R*L);
beam.vx0=v0*ones(1,Nb);
beam.vy0=0*ones(1,Nb);
beam.x0=xb;

species=[plasma beam ion];

% Run pic solver
ani=[0 0]; % Animate? [x y] => x=0 for don't animate, 1 for animate; y=frame speed (skip)
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t,xp,xb,vxp,vxb]=pic(species,nx,nt,dt,L,B0,method,ani);

% Animate results
skip=10;
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

% % Plot results
% times=[0 1 1.2 1.3 1.4 1.5];
% for i=1:length(times)
%     tlist=t(t<=times(i));
%     tnear=tlist(end);
%     tind(i)=find(t==tnear);
% end
% figure
% for i=1:length(tind)
%     Titl=sprintf('t = %2.1f',t(tind(i)));
%     subplot(length(tind)/2,2,i)
%     plot(xp(:,tind(i)),vxp(:,tind(i)),'.',xb(:,tind(i)),vxb(:,tind(i)),'.')
%     title(Titl)
%     xlabel('position')
%     ylabel('vx')
% end