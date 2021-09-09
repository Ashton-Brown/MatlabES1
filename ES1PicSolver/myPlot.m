%% Plot parameters of interest
% This script is called by pic when animation is on.  It animates rho, phi,
% E, and optionally F in time during the pic solver.

dx=L/nx;
xgrid=(0:dx:(L-dx))+dx/2;

% Calculate total energy
[ESe,Ke,De,THe]=energies(N,dx,rho,phi,vx,vy,m);
Etot=ESe+sum(Ke);
phiinterp=interpPhi(phi,x,N,nx,L,method(1));
TITLE=sprintf('t = %1.3e   E_{tot}=%1.3e',t,Etot);


figure(1)
cmap=colormap('lines');
% rho
subplot(4,1,1)
stairs(xgrid-dx/2,rho)
hold on
n=1;
for sp=1:length(N)
    plot(x(n:(n-1+N(sp))),0*x(n:(n-1+N(sp)))+0.2*(sp-1),'o')
    n=n+N(sp);
end
hold off
ax = gca;
     ax.XAxis.MinorTick = 'on';
     ax.XAxis.MinorTickValues = [xgrid-dx/2,xgrid(end)+dx/2];
     ax.XMinorGrid = 'on';
title(TITLE)
ylabel('\rho')
xlim([0 L])
if min(rho)<rholimits(1)
    rholimits(1)=min(rho);
end
if max(rho)>rholimits(2)
    rholimits(2)=max(rho);
end
ylim(rholimits)

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
if min(phi)<Vlimits(1)
    Vlimits(1)=min(phi);
end
if max(phi)>Vlimits(2)
    Vlimits(2)=max(phi);
end
ylim(Vlimits)
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
if min(E0)<Elimits(1)
    Elimits(1)=min(E0);
end
if max(E0)>Elimits(2)
    Elimits(2)=max(E0);
end
ylim(Elimits)
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