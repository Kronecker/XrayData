function [ beta0 ] = beta0Cosd( x,y )
%beta0=beta0Gauss(x,y) Preconditioning for fitting parameters beta0 for a
%cos^2 of type y=a*cos(x+b)^2+c with beta0=[a,b,c]
try
    c=min(y);
    b=-x(find(max(y)==y,1));
    a=max(y);
    beta0=[a,b,c];
catch me
    beta0=[1,0,0];
    warning(me.message);
end
end