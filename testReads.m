if(~exist('fileNum','var'))    
    fileFormatString='scan%04dt.dat';
end
    
if(~exist('fileNum','var'))
    fileNum=88;
end
path='sampleData\sample2\';

[t]=readFile(fileFormatString,fileNum, path);












