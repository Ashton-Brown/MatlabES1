%% Project 5-17 Magnetized Ring-Velocity Distribution of Birdsall and Langdon

addpath('ES1PicSolver')
clear;close all;

% Define spacial and temporal grid parameters
L=2*pi;
nx=64;
T=120;
dt=2e-1;
nt=T/dt;

% Primary parameters for this project
R=10;
wp=1;
wc=R^(-1/2);
vp0=4.5*wc/(2*pi/L);

% Define initial plasma and magentic field
qm=1;
B0=wc/qm;

N=4096;

xmode=1;
x1=1e-3;
x0=init(N,L,xmode,x1,0,0,0,0,0);
x0=scramble(x0);
theta=(1:N)*2*pi/N-pi/N;
vx0=vp0*cos(theta);
vy0=vp0*sin(theta);

ion=Species(N,L);
ion.qm=qm;
ion.vx0=vx0;
ion.vy0=vy0;
ion.x0=x0;

species=ion;

% Run pic solver
ani=0;
method=[1 0];
[t,x,vx,vy]=pic(species,nx,nt,dt,L,B0,method,ani);

% Animate results
skip=5;
figure
for i=1:skip:length(t)
    Titl=sprintf('t = %2.1f',t(i));
    plot(vx(:,i),vy(:,i),'.')
    title(Titl)
    xlabel('vx')
    ylabel('vy')
    axis(2*vp0*[-1 1 -1 1])
    pause(0.1)
end

function eggs=scramble(egg)
N=length(egg);
eggs=zeros(1,N);
left=1:N;
i=1;
while i<N
    I=floor(rand()*N)+1;
    if ~isempty(left(left==I))
        eggs(i)=egg(I);
        left=left(left~=I);
        i=i+1;
    end
end
end