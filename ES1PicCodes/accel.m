function vx_new = accel(vx,E,qm,dt,move_yn)
for sp=1:length(qm)
    if move_yn{sp} == 'y'
        vx_new{sp}=vx{sp}+qm(sp)*E{sp}*dt/2;
    elseif move_yn{sp} == 'n'
        vx_new{sp}=zeros(size(vx{sp}));
    end
end
end