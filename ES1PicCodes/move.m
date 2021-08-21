function x_new = move(x,vx,dt,L)
for sp=1:length(x)
    xp=x{sp}+vx{sp}*dt;
    while ~isempty(xp(xp<0)) || ~isempty(xp(xp>L))
        xp(xp<0)=xp(xp<0)+L;
        xp(xp>L)=xp(xp>L)-L;
    end
    x_new{sp}=xp;
end