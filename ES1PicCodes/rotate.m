function [vx_new,vy_new] = rotate(vx,vy,wc,dt)
for sp=1:length(wc)
    c=cos(wc(sp)*dt);
    s=sin(wc(sp)*dt);
    vx_new{sp}=c*vx{sp}+s*vy{sp};
    vy_new{sp}=-s*vx{sp}+c*vy{sp};
end