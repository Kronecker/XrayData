function [ y ] = myparabola( beta,x )
%Parabel(beta,x) mit a*(x+b)^2+c  beta0=[a,b,c]
y=beta(1)*(x+beta(2)).^2+beta(3);
end

