function E = calc_E(phi,dx)
% This function calculates the electric field E at the grid points based on
% the derivative of the potential phi, using a central difference scheme.

N=length(phi);
E=-(phi(3:N)-phi(1:N-2))/(2*dx);
end