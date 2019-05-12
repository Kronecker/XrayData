function [ fwhm ,lowerCenterPosition,centerPosition,upperCenterPosition,maxVal] = getFWHM( x,y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[maxVal,maxIdx]=max(y);

lowerIdx=find(y>=maxVal/2,1);
if(size(y,1)==1)
upperIdx=numel(y)+1-find(fliplr(y)>=maxVal/2,1);
elseif(size(y,2)==1)
    upperIdx=numel(y)+1-find(flipud(y)>=maxVal/2,1);
else
   'pls input a vector'; 
end

lowerFirstValue=y(lowerIdx);
lowerFirstPosition=x(lowerIdx);
lowerBeforeFirstValue=y(lowerIdx-1);
lowerBeforeFirstPosition=x(lowerIdx-1);

m=(lowerFirstValue-lowerBeforeFirstValue)/(lowerFirstPosition-lowerBeforeFirstPosition);
n=-m*lowerFirstPosition+lowerFirstValue;

lowerCenterPosition=(maxVal/2-n)/m;

if(upperIdx>=numel(y))
    upperIdx=numel(y)-1;
end
upperFirstValue=y(upperIdx+1);
upperFirstPosition=x(upperIdx+1);
upperBeforeFirstValue=y(upperIdx);
upperBeforeFirstPosition=x(upperIdx);

m=(upperFirstValue-upperBeforeFirstValue)/(upperFirstPosition-upperBeforeFirstPosition);
n=-m*upperFirstPosition+upperFirstValue;

upperCenterPosition=(maxVal/2-n)/m;

centerPosition=(upperCenterPosition+lowerCenterPosition)/2;

%fwhm=x(upperIdx)-x(lowerIdx)
fwhm=upperCenterPosition-lowerCenterPosition;


end

