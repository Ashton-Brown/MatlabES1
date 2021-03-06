function [x,v] = init(N,L,xmode,x1,thetax,v0,vmode,v1,thetav)
% This function allows for a quick way to initialize a plasma with
% sinusoidal perturbations to a uniform distribution.

dx=L/N;
x0=((1:N)-0.5)*dx;
x=x0+x1*cos(2*pi*xmode*x0/L+thetax);
v=v0+v1*sin(2*pi*vmode*x0/L+thetav);
end