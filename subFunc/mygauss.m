function [ y ] = mygauss( beta,x )
%Gaussfunktion(beta,x) mit beta=[y0, xc, w, A] , fwhm = sqrt(2*ln(2)) * w
y=beta(1) + (beta(4)./(beta(3).*sqrt(pi*2))).*exp(-1/2.*((x-beta(2))./beta(3)).^2);
end

