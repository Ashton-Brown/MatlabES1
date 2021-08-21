function Einterp = interpE(E,x,N,nx,L,method)
% This function interpolates the electric field, E, valued on the
% gridpoints, to the positions of the particles, x, using
% nearest-grid-point method or cloud-in-cell method.

dx=L/(nx-1);
n=1;

switch method
    case 0
        for sp=1:length(x)
            x_ind=round(x{sp}/dx)+1;
            x_ind(x_ind<=0)=x_ind(x_ind<=0)+nx;
            x_ind(x_ind>nx)=x_ind(x_ind>nx)-nx;
            Einterp{sp}=zeros(size(x_ind));
            for i=1:length(x_ind)
                Einterp{sp}(i)=E(x_ind(i));
            end
        end
    case 1
        for sp=1:length(N)
            X=x(n:(n-1+N(sp)));
            x_ind=floor(X/dx)+1;
            x_ind(x_ind<=0)=x_ind(x_ind<=0)+nx;
            x_ind(x_ind>nx)=x_ind(x_ind>nx)-nx;
            Einterp{sp}=zeros(size(x_ind));
            for i=1:length(x_ind)
                Xj=dx*(x_ind(i)-1);
                Xjp1=dx*(x_ind(i));
                if x_ind(i)==nx
                    Einterp{sp}(i)=E(x_ind(i))/dx*(Xjp1-X(i))+E(1)/dx*(X(i)-Xj);
                else
                    Einterp{sp}(i)=E(x_ind(i))/dx*(Xjp1-X(i))+E(x_ind(i)+1)/dx*(X(i)-Xj);
                end
            end
            n=n+N(sp);
        end
end
end