%% e-e stream to compare to es1 by rweigel

addpath('ES1PicCodes')
clear; close all; clc;

% Define spacial and temporal grid parameters
L=2*pi;
nx=512;
dt=1e-1;
nt=300;
T=nt*dt;

% Define initial plasma and magentic field
B0=0;

fac=1e0;
Ne1=2048;
Ne2=2048;
Ni=fac*(Ne1+Ne2);

mode=1;
x11=0.0001;
x12=-0.0001;
[xe1,v01]=init(Ne1,L,mode,x11,0,1e-2,0,0,0);
[xe2,v02]=init(Ne2,L,mode,x12,0,-1e-2,0,0,0);
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

% Grab es1 results for comparing
fileID=fopen('2stream.inp.txt','r');
A=fscanf(fileID,'%f');
a=1;
for k=1:nt
    for i=1:Ne1
        Xe1(i,k)=A(a);
        a=a+1;
    end
    for i=1:Ne2
        Xe2(i,k)=A(a);
        a=a+1;
    end
    for i=1:Ne1
        VXe1(i,k)=A(a);
        a=a+1;
    end
    for i=1:Ne2
        VXe2(i,k)=A(a);
        a=a+1;
    end
end

% Print results
% for k=1:length(t)
%     fprintf('\n')
%     for i=1:Ne1
%         fprintf('%1.5f ',xe1(i,k)*nx/L)
%     end
%     for i=1:Ne2
%         fprintf('%1.5f ',xe2(i,k)*nx/L)
%     end
%     fprintf('\n')
%     for i=1:Ne1
%         fprintf('%1.5f ',vxe1(i,k)*nx/L)
%     end
%     for i=1:Ne2
%         fprintf('%1.5f ',vxe2(i,k)*nx/L)
%     end
% end
% fprintf('\n\n')

% Plot comparison
figure

subplot(2,2,1)
plot(t,xe1*nx/L,'.')
hold on
plot(t,Xe1,'o')

subplot(2,2,2)
plot(t,xe2*nx/L,'.')
hold on
plot(t,Xe2,'o')

subplot(2,2,3)
plot(t,vxe1*nx/L/10,'.')
hold on
plot(t,VXe1,'o')

subplot(2,2,4)
plot(t,vxe2*nx/L/10,'.')
hold on
plot(t,VXe2,'o')