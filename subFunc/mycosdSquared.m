function [ y ] = mycosdSquared( beta,x )
%Cos^2( beta,x ) with y=a*cos(x+b)^2+c  beta=[a,b,c];
y=(beta(3)+beta(1)*cosd(x+beta(2)).^2)';
end

