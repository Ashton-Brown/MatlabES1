%% Project 5-9 e-e Stream of Birdsall and Langdon

addpath('ES1PicCodes')
clear; close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=32*2; % I have found that the stability depends on the # of grid cells
T=30;
dt=1e-1;
nt=T/dt;

% Define initial plasma and magentic field
B0=0;

fac=1e1;
Ne1=320;
Ne2=320;
Ni=fac*(Ne1+Ne2);

xmode=0;
x11=0;
x12=0.001;
vmode=1;
v1=0.001;
theta=1.5*pi/L;
[xe1,v01]=init(Ne1,L,xmode,x11,0,1,vmode,-v1,theta);
[xe2,v02]=init(Ne2,L,xmode,x12,0,-1,vmode,v1,theta);
[xi,v0i]=init(Ni,L,0,0,0,0,0,0,0);

ion=Species;
ion.N=Ni;
ion.q=1/fac;
ion.vx0=v0i;
ion.vy0=0*ones(1,Ni);
ion.x0=xi;
ion.move_yn='n';

electron1=Species;
electron1.N=Ne1;
electron1.q=-1;
electron1.vx0=v01;
electron1.vy0=0*ones(1,Ne1);
electron1.x0=xe1;

electron2=Species;
electron2.N=Ne2;
electron2.q=-1;
electron2.vx0=v02;
electron2.vy0=0*ones(1,Ne2);
electron2.x0=xe2;

species=[electron1 electron2 ion];

% Run pic solver
ani=[0 0]; % Animate? [x y] => x=0 for don't animate, 1 for animate; y=frame speed (skip)
method=[1 0]; % Choose methods for (1) weighting (0 for NGP and 1 for CIC) and (2) phi solution (0 for FD and 1 for FFT)
[t,xe1,xe2,vxe1,vxe2,ESE,KE,DE,THE]=pic(species,nx,nt,dt,L,B0,method,ani);

% Animate results
skip=2;
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

% Plot results
% times=[1 11 13 14 15 17 24];
% for i=1:length(times)
%     tlist=t(t<=times(i));
%     tnear=tlist(end);
%     tind(i)=find(t==tnear);
% end
% figure
% for i=1:length(tind)
%     Titl=sprintf('t = %2.1f',t(tind(i)));
%     subplot((length(tind)+1)/2,2,i)
%     plot(xe(:,tind(i)),vxe(:,tind(i)),'.')
%     xlim([0 L])
%     title(Titl)
%     xlabel('position')
%     ylabel('vx')
% end
% subplot((length(tind)+1)/2,2,i+1)
% plot(t,ESE+sum(KE,1));%,t,DE,t,THE,t,DE+THE)
% legend('Etot')%'F','D','T')
% xlabel('time')
% ylabel('Energy')