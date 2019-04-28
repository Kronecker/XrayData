fileFormatString='scan%04d.dat';
if(~exist('fileNum','var'))
    fileNum=160;
end
path='SampleData';

[t]=readFile(fileNum, path, fileFormatString)
[t]=readFile('scan0126.dat', path, fileFormatString)

%t=readXrayScanXfel(fileFormatString, fileNum, path)




%plot(data(:,1),data(:,5));











