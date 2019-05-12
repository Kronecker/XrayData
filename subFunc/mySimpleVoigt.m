function [ Y,hwb ] = mySimpleVoigt( beta,X )
%mySimpleVoigt beta = [y0, A, wL, wG, xc]
%   function definiton from origin
ln2=log(2);
vIFun=@(t) (exp(-t.^2)./((sqrt(ln2)*beta(3)/beta(4)).^2 + (2*sqrt(ln2)*(X-beta(5))/beta(4)-t).^2));
vI=integral(vIFun,-inf,inf,'ArrayValued',true);
Y= beta(1)+(beta(2)*2*ln2*beta(3))/(pi.^(1.5)*beta(4).^2)*vI;
hwb = 0.5346*beta(3) + sqrt( 0.2166*beta(3).^2 + beta(4).^2 );
end

