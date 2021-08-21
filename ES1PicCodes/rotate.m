function [vx_new,vy_new] = rotate(vx,vy,N,wc,dt)
n=1;
for sp=1:length(N)
    c=cos(wc(sp)*dt);
    s=sin(wc(sp)*dt);
    vx_new(n:(n-1+N(sp)))=c*vx(n:(n-1+N(sp)))+s*vy(n:(n-1+N(sp)));
    vy_new(n:(n-1+N(sp)))=-s*vx(n:(n-1+N(sp)))+c*vy(n:(n-1+N(sp)));
    n=n+N(sp);
end