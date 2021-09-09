function [ESE,KE,DE,THE] = energies(N,dx,rho,phi,vx,vy,m)
% Calculate the various energies.

%% Electrostatic energy
ESE=dx/2*sum(rho.*phi(2:end-1)); % See Ch 10 of Birdsall and Langdon

%% Kinetic energy
v=sqrt(vx.^2+vy.^2);
KE=zeros(1,length(N));
n=1;
for sp=1:length(N)
    KE(sp)=1/2*m(sp)*sum(v(n:(n-1+N(sp))).^2);
    n=n+N(sp);
end

%% Drift energy
DE=0;
n=1;
for sp=1:length(N)
    vbar=sqrt((sum(vx(n:(n-1+N(sp))))/N(sp))^2+(sum(vy(n:(n-1+N(sp))))/N(sp))^2);
    DE=DE+1/2*N(sp)*m(sp)*vbar^2;
    n=n+N(sp);
end

%% Thermal Energy
THE=0;
n=1;
for sp=1:length(N)
    vbar=sqrt((sum(vx(n:(n-1+N(sp))))/N(sp))^2+(sum(vy(n:(n-1+N(sp))))/N(sp))^2);
    THE=THE+1/2*N(sp)*m(sp)*(mean(v(n:(n-1+N(sp))).^2)-vbar^2);
    n=n+N(sp);
end
end