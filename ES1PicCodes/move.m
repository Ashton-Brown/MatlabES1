function x_new = move(x,vx,N,dt,L)
n=1;
for sp=1:length(N)
    xp=x(n:(n-1+N(sp)))+vx(n:(n-1+N(sp)))*dt;
    while ~isempty(xp(xp<0)) || ~isempty(xp(xp>L))
        xp(xp<0)=xp(xp<0)+L;
        xp(xp>L)=xp(xp>L)-L;
    end
    x_new(n:(n-1+N(sp)))=xp;
    n=n+N(sp);
end