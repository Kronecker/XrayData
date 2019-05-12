function [ beta0 ] = beta0Parabola( x,y )
%beta0=beta0Parabola(x,y) Preconditioning for fitting parameters beta0 for a
%parabola of type a*(x+b)^2+c (a>0) with beta0=[a,b,c]
try
id=find(y==min(y),1);
b=-x(id);
c=y(id);
if((x(1)+b)>1e-4)
    a=(y(1)-c)/(x(1)+b).^2;
else
    a=(y(end)-c)/(x(end)+b).^2;
end
beta0=[a,b,c];
catch me
   beta0=[1,0,0] ;
   warning(me.message);
end
end

