function [ beta0 ] = beta0Gauss( x,y )
%beta0=beta0Gauss(x,y) Preconditioning for fitting parameters beta0 for a
%gaussian function with beta0=[y0,xc,w,A];
try
y0=mean([mean(y(1:5)),mean(y(end-5:end))]);
A=trapz(x,y)-y0*abs(x(end)-x(1));
maxi=max(y);
id=find(y==maxi,1);
xc=x(id);
id=find(y>=(maxi+y0)/2);
w=(x(id(end))-x(id(1)))*0.85;
beta0=[y0,xc,w,A];
catch me
beta0=[0,0,1,1];    
warning(me.message);
end
end