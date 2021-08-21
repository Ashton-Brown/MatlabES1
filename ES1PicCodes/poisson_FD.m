function phi = poisson_FD(rho,dx)
% This function solves poisson's equation using finite differencing to set
% up a set of linear equations.  These equations are solved using MATLAB's
% linear algebra/matrix solver \.

N=length(rho);
p=zeros(1,N+2); % Adds a ghost point on each end
p(2:N+1)=-dx^2*rho;
A=zeros(N+2);
for i=2:N+1
    A(i,i-1:i+1)=[1 -2 1];
end
A(1,1)=1; % Periodic boundary conditions for ghost points
A(N+2,N+2)=1;
phi=A\p';
phi=phi';
end