function rho = get_rho(x,q,N,nx,L,method)
% This function maps the particles to the grid cells to obtain charge 
% density rho.  It uses either nearest grid point (NGP) or cloud in cell
% (CIC), depending on input 'method'.  The values of rho are then uniformly
% agjusted to force the average to be zero, which functions as the uniform
% neutralizing background.
% method = 0 => NGP
% method = 1 => CIC

rho=zeros(1,nx);
dx=L/nx;
n=1;

switch method
    case 0 % Nearest grid point
        for sp=1:length(N)
            x_ind=floor(x(n:(n-1+N(sp)))/dx)+1;
            x_ind(x_ind<=0)=x_ind(x_ind<=0)+nx;
            x_ind(x_ind>nx)=x_ind(x_ind>nx)-nx;
            for i=1:length(x_ind)
                rho(x_ind(i))=rho(x_ind(i))+q(sp)/dx;
            end
            n=n+N(sp);
        end
    case 1 % Cloud in cell
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
                rho(x_ind(i))=rho(x_ind(i))+q(sp)/dx*(Xjp1-X(i))/dx;
                if x_ind(i)==nx
                    rho(1)=rho(1)+q(sp)/dx*(X(i)-Xj)/dx;
                else
                    rho(x_ind(i)+1)=rho(x_ind(i)+1)+q(sp)/dx*(X(i)-Xj)/dx;
                end
            end
            n=n+N(sp);
        end
end

% Neutralizing uniform background
rho=rho-mean(rho);
end