function [ESE,KE,DE,THE] = energies(dx,E,vx,vy,m)
% Calculate the various energies.

%% Electrostatic energy
ESE=dx/2*sum(E.^2);%1/2*sum(rho.*phi(2:end-1));

%% Kinetic energy
for sp=1:length(m)
    KE{sp}=1/2*m(sp)*sum(vx{sp}.^2+vy{sp}.^2);
end

%% Drift energy
DE=0;
for sp=1:length(m)
    DE=DE+1/2*m(sp)*mean(sqrt(vx{sp}.^2+vy{sp}.^2))^2;
end

%% Thermal Energy
THE=0;
for sp=1:length(m)
    THE=THE+1/2*m(sp)*(mean(vx{sp}.^2+vy{sp}.^2)-mean(sqrt(vx{sp}.^2+vy{sp}.^2))^2);
end
end