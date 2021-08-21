function Phiinterp = interpPhi(phi,x,nx,L,method)
% This function interpolates the potential, phi, valued on the
% gridpoints, to the positions of the particles, x, using
% nearest-grid-point method or the cloud-in-cell method.

dx=L/(nx-1);
phi=phi(2:end-1);

switch method
    case 0
        for sp=1:length(x)
            x_ind=round(x{sp}/dx)+1;
            x_ind(x_ind<=0)=x_ind(x_ind<=0)+nx;
            x_ind(x_ind>nx)=x_ind(x_ind>nx)-nx;
            Phiinterp{sp}=zeros(size(x_ind));
            for i=1:length(x_ind)
                Phiinterp{sp}(i)=phi(x_ind(i));
            end
        end
    case 1
        for sp=1:length(x)
            X=x{sp};
            x_ind=floor(X/dx)+1;
            x_ind(x_ind<=0)=x_ind(x_ind<=0)+nx;
            x_ind(x_ind>nx)=x_ind(x_ind>nx)-nx;
            Phiinterp{sp}=zeros(size(x_ind));
            for i=1:length(x_ind)
                Xj=dx*(x_ind(i)-1);
                Xjp1=dx*(x_ind(i));
                if x_ind(i)==nx
                    Phiinterp{sp}(i)=phi(x_ind(i))/dx*(Xjp1-X(i))+phi(1)/dx*(X(i)-Xj);
                else
                    Phiinterp{sp}(i)=phi(x_ind(i))/dx*(Xjp1-X(i))+phi(x_ind(i)+1)/dx*(X(i)-Xj);
                end
            end
        end
end
end