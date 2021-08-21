function [ESE,KE,DE,THE] = energies(N,dx,E,vx,vy,m)
% Calculate the various energies.

%% Electrostatic energy
ESE=dx/2*sum(E.^2);%1/2*sum(rho.*phi(2:end-1));

%% Kinetic energy
n=1;
for sp=1:length(N)
    KE(sp)=1/2*m(sp)*sum(vx(n:(n-1+N(sp))).^2+vy(n:(n-1+N(sp))).^2);
    n=n+N(sp);
end

%% Drift energy
DE=0;
n=1;
for sp=1:length(N)
    DE=DE+1/2*m(sp)*mean(sqrt(vx(n:(n-1+N(sp))).^2+vy(n:(n-1+N(sp))).^2))^2;
    n=n+N(sp);
end

%% Thermal Energy
THE=0;
n=1;
for sp=1:length(N)
    THE=THE+1/2*m(sp)*(mean(vx(n:(n-1+N(sp))).^2+vy(n:(n-1+N(sp))).^2)-mean(sqrt(vx(n:(n-1+N(sp))).^2+vy(n:(n-1+N(sp))).^2))^2);
    n=n+N(sp);
end
end