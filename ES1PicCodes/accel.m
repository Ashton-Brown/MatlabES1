function vx_new = accel(vx,N,E,qm,dt,move_yn)
n=1;
for sp=1:length(N)
    if move_yn{sp} == 'y'
        vx_new(n:(n-1+N(sp)))=vx(n:(n-1+N(sp)))+qm(sp)*E{sp}*dt/2;
    elseif move_yn{sp} == 'n'
        vx_new(n:(n-1+N(sp)))=zeros(size(vx(n:(n-1+N(sp)))));
    end
    n=n+N(sp);
end
end