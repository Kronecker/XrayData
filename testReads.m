fileFormatString='scan%04d.dat';
if(~exist('fileNum','var'))
    fileNum=160;
end
path='SampleData';

[t]=readFile(fileFormatString, fileNum, path)

%t=readXrayScanXfel(fileFormatString, fileNum, path)




%plot(data(:,1),data(:,5));











