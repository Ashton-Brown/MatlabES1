function Phiinterp = interpPhi(phi,x,N,nx,L,method)
% This function interpolates the potential, phi, valued on the
% gridpoints, to the positions of the particles, x, using
% nearest-grid-point method or the cloud-in-cell method.

dx=L/nx;
phi=phi(2:end-1);
Phiinterp=cell(1,length(N));
n=1;

switch method
    case 0
        for sp=1:length(N)
            x_ind=floor(x(n:(n-1+N(sp)))/dx)+1;
            x_ind(x_ind<=0)=x_ind(x_ind<=0)+nx;
            x_ind(x_ind>nx)=x_ind(x_ind>nx)-nx;
            Phiinterp{sp}=zeros(size(x_ind));
            for i=1:length(x_ind)
                Phiinterp{sp}(i)=phi(x_ind(i));
            end
            n=n+N(sp);
        end
    case 1
        for sp=1:length(N)
            X=x(n:(n-1+N(sp)));
            x_ind=round(X/dx);
            Phiinterp{sp}=zeros(size(x_ind));
            for i=1:length(x_ind)
                if x_ind(i)<=0
                    x_ind(i)=x_ind(i)+nx;
                    X(i)=X(i)+L;
                end
                if x_ind(i)>nx
                    x_ind(i)=x_ind(i)-nx;
                    X(i)=X(i)-L;
                end
                Xj=dx*(x_ind(i)-1)+dx/2;
                Xjp1=dx*(x_ind(i))+dx/2;
                if x_ind(i)==nx
                    Phiinterp{sp}(i)=phi(x_ind(i))/dx*(Xjp1-X(i))+phi(1)/dx*(X(i)-Xj);
                else
                    Phiinterp{sp}(i)=phi(x_ind(i))/dx*(Xjp1-X(i))+phi(x_ind(i)+1)/dx*(X(i)-Xj);
                end
            end
            n=n+N(sp);
        end
end
end