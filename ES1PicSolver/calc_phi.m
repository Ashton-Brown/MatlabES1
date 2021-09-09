function phi = calc_phi(rho,dx,method)
% This function solves poisson's equation for phi.  The input 'method'
% determines which method, or case, to use to solve.
% method = 0 => finite difference method solved with '/', Dirchlet BCs
% method = 1 => fast Fourrier transform method (periodic BCs)
% method = 2 => finite difference method solved with '/', mixed BCs

N=length(rho);
switch method
    case 0 % This matches most closely with App D of Birdsall and Langdon
        rho=[rho(N) rho rho(1)];
        p=-dx^2*(rho(1:N)+10*rho(2:N+1)+rho(3:N+2))/12; % See 4-9 of Birdsall and Langdon
        phi0=0; % The bias
        p(1)=phi0;
        A=zeros(N);
        for i=2:N-1
            A(i,i-1:i+1)=[1 -2 1];
        end
        A(1,1)=1; % Setting equal to bias
        A(N,1)=1;A(N,N-1:N)=[1 -2]; % Periodic boundary condition
        phi=A\p';
        phi=phi';
        
    case 1
        rhok=fft(rho);
        n=linspace(-N/2,N/2-1,N);
        k=n*(2*pi/L);
        K2=k.^2.*(sin(dx*k/2)./(dx*k/2)).^2;
        phik=rhok./K2;
        phi=real(ifft(phik));
        
    case 2
        rho=[rho(N) rho rho(1)];
        p=-dx^2*(rho(1:N)+10*rho(2:N+1)+rho(3:N+2))/12;
        p(1)=0;p(N)=0; % Part of Neumann BCs
        A=zeros(N);
        for i=2:N-1
            A(i,i-1:i+1)=[1 -2 1];
        end
        A(1,1:2)=[1 0]; % Dirchlet BC
        A(N,N-1:N)=[1 -1]; % Neumann BC
        phi=A\p';
        phi=phi';
        
end
phi=[phi(N) phi phi(1)]; % Add periodic endpoints, used when differencing for E
end