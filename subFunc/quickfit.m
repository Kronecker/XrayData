function [ beta,func, R,a,convb,mse,d,e ] = quickfit( x,y, func, beta0, opts )
%quickfit( x,y, func, beta0 )

mode='user';
if( ~isa(func, 'function_handle'))
   if(strcmp('gauss',func))
       func=@mygauss;
       mode='gauss';
   elseif(strcmp('parabola',func))
       func=@myparabola;
       mode='parabola';
   elseif(strcmp('cosd2',func))
       mode='cosd2';
       func=@mycosdSquared;
   else
       error('Specify a function handle or use one of the three default functions, > gauss < , > parabola < , > cosd2 <');
   end       
end

if(isempty(beta0)) 
    if(strcmp('gauss',mode))
       beta0=beta0Gauss(x,y);
   elseif(strcmp('parabola',mode))
       beta0=beta0Parabola(x,y);
   elseif(strcmp('cosd2',mode))
       beta0=beta0Cosd(x,y);
   else
       error('You need to specify start fitting parameters for your own functions.');
   end 
end

[beta,R,a,convb,mse,d,e]=nlinfit(x,y,func,beta0,opts);
end

