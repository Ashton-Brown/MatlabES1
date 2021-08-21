%% Plot parameters of interest

xgrid=linspace(0,L,nx);

% Calculate total energy
[ESe,Ke,De,THe]=energies(N,dx,E0,vx,vy,m);
Etot=ESe+sum(Ke);
phiinterp=interpPhi(phi,x,N,nx,L,method(1));
TITLE=sprintf('t = %1.3e   E_{tot}=%1.3e',t,Etot);


figure(1)
cmap=colormap('lines');
% rho
subplot(4,1,1)
plot(xgrid,rho)
hold on
n=1;
for sp=1:length(N)
    plot(x(n:(n-1+N(sp))),0*x(n:(n-1+N(sp)))+0.2*(sp-1),'o')
    n=n+N(sp);
end
hold off
title(TITLE)
ylabel('\rho')
ylim([-2 2])
xlim([0 L])

% phi
subplot(4,1,2)
plot(xgrid,phi(2:end-1))
ylabel('\phi')
hold on
n=1;
for sp=1:length(N)
    plot(x(n:(n-1+N(sp))),phiinterp{sp},'o')
    n=n+N(sp);
end
xlim([0 L])
hold off

% E
subplot(4,1,3)
plot(xgrid,E0)
hold on
n=1;
for sp=1:length(N)
    plot(x(n:(n-1+N(sp))),E{sp},'o')
    n=n+N(sp);
end
xlim([0 L])
hold off
xlabel('position')
ylabel('E')

% Force
if length(ani)==3
    n=1;
    for sp=1:length(species)
        NN=species(sp).N;
        if sp==ani(3)
            subplot(4,1,4)
            plot(x(n:(n-1+NN)),q(ani(3))*E{sp},'o','Color',cmap(ani(3)+1,:))
            hold on
            xlim([0 L])
            xlabel('position')
            ForceLabel=sprintf('Force on species %1.0f',ani(3));
            ylabel(ForceLabel)
        end
        n=n+NN;
    end
end

pause(0.1)