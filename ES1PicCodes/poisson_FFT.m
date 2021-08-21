function phi = poisson_FFT(rho,L,dx)
% This function solves poisson's equation using fast fourier tranforms.

N=length(rho);
rhok=fft(rho);
n=linspace(-N/2,N/2-1,N);
k=n*(2*pi/L);
K2=k.^2.*(sin(dx*k/2)./(dx*k/2)).^2;
phik=rhok./K2;
phi=real(ifft(phik));
phi=[phi(N) phi phi(1)];
end