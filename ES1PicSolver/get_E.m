function Einterp = get_E(E,x,N,nx,L,method)
% This function outputs the field E at the particles by interpolating to
% the particles from the field calculated at the gridpoints.  It matches
% the method used to get rho.
% method = 0 => NGP
% method = 1 => CIC

Einterp=cell(1,length(N));
dx=L/nx;
n=1;

switch method
    case 0
        for sp=1:length(N)
            x_ind=floor(x(n:(n-1+N(sp)))/dx)+1;
            x_ind(x_ind<=0)=x_ind(x_ind<=0)+nx;
            x_ind(x_ind>nx)=x_ind(x_ind>nx)-nx;
            for i=1:length(x_ind)
                Einterp{sp}(i)=E(x_ind(i));
            end
            n=n+N(sp);
        end
    case 1
        for sp=1:length(N)
            X=x(n:(n-1+N(sp)));
            x_ind=round(X/dx);
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
                    Einterp{sp}(i)=E(x_ind(i))/dx*(Xjp1-X(i))+E(1)/dx*(X(i)-Xj);
                else
                    Einterp{sp}(i)=E(x_ind(i))/dx*(Xjp1-X(i))+E(x_ind(i)+1)/dx*(X(i)-Xj);
                end
            end
            n=n+N(sp);
        end
end
end