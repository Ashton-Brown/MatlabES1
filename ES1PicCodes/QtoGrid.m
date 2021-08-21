function rho = QtoGrid(x,q,nx,L,method)
% This function maps the particles to the grid cells to obtain charge 
% density rho.  It uses the nearest-grid point method (i.e., whichever cell
% the particle is in) for method=0, and the cloud-in-cell method for method
% = 1.

rho=zeros(1,nx);
dx=L/(nx-1);

switch method
    case 0 % Nearest grid point
        for sp=1:length(q)
            x_ind=round(x{sp}/dx)+1;
            x_ind(x_ind<=0)=x_ind(x_ind<=0)+nx;
            x_ind(x_ind>nx)=x_ind(x_ind>nx)-nx;
            for i=1:length(x_ind)
                rho(x_ind(i))=rho(x_ind(i))+q(sp)/dx;
            end
        end
    case 1 % Cloud in cell
        for sp=1:length(q)
            X=x{sp};
            x_ind=floor(X/dx)+1;
            x_ind(x_ind<=0)=x_ind(x_ind<=0)+nx;
            x_ind(x_ind>nx)=x_ind(x_ind>nx)-nx;
            for i=1:length(x_ind)
                Xj=dx*(x_ind(i)-1);
                Xjp1=dx*(x_ind(i));
                rho(x_ind(i))=rho(x_ind(i))+q(sp)/dx*(Xjp1-X(i));
                if x_ind(i)==nx
                    rho(1)=rho(1)+q(sp)/dx*(X(i)-Xj);
                else
                    rho(x_ind(i)+1)=rho(x_ind(i)+1)+q(sp)/dx*(X(i)-Xj);
                end
            end
        end
end
end