%% Plot parameters of interest

xgrid=linspace(0,L,nx);

% Calculate total energy
[ESe,Ke,De,THe]=energies(dx,E0,vx,vy,m);
Ke=cell2mat(Ke);
Etot=ESe+sum(Ke);
phiinterp=interpPhi(phi,x,nx,L,method(1));
TITLE=sprintf('t = %1.3e   E_{tot}=%1.3e',t,Etot);


figure(1)
cmap=colormap('lines');
% rho
subplot(4,1,1)
plot(xgrid,rho)
hold on
for sp=1:length(x)
    plot(x{sp},0*x{sp}+0.2*(sp-1),'o')
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
for sp=1:length(x)
    plot(x{sp},phiinterp{sp},'o')
end
xlim([0 L])
hold off

% E
subplot(4,1,3)
plot(xgrid,E0)
hold on
for sp=1:length(x)
    plot(x{sp},E{sp},'o')
end
xlim([0 L])
hold off
xlabel('position')
ylabel('E')

% Force
if length(ani)==3
    subplot(4,1,4)
    plot(x{ani(3)},q(ani(3))*E{sp},'o','Color',cmap(ani(3)+1,:))
    hold on
    xlim([0 L])
    xlabel('position')
    ForceLabel=sprintf('Force on species %1.0f',ani(3));
    ylabel(ForceLabel)
end

pause(0.1)