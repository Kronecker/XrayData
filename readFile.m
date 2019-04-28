function [ obj ] = readFile(fileNum, path, fileFormatString )

% Props
timepxName='Timepix';
timePxCols=2;

dioMeasurePSec=10;
startData=1+1+3;  % start + x + timex3

% Fetch Data
try
        cont=readXrayScanXfel(fileFormatString, fileNum, path);
catch me
    
    rethrow(me);
end
obj=XrayData();

% Convert to obj
obj.fileName=cont.fileName;
obj.fileNum=cont.fileNum;
obj.path=cont.path;
obj.timestr=cont.timestr;

obj.x=cont.data(:,1);

obj.time=cont.data(1,2);
obj.subtime=cont.data(1,3);
obj.timepoints=cont.data(1,4);

obj.xname=cont.header{1};

% Determine structure of mean values
ynames=cont.header(5:8);
tempCount=[1:numel(ynames)];
timepxId=tempCount(strcmp(ynames,timepxName));

offs=0;
% Sort mean values, timepx to the front
if(isempty(timepxId))
    warning(['Could not find ',timepxName,' data, adding zeros instead! Pls check names.']);
    obj.yname=[{timepxName},ynames];
    obj.y=[zeros([1,size(cont.data,1)]),cont.data(:,startData:startData+2)];
    offs=-1;
elseif(timepxId~=1)
    warning(['Putting timepx data to the first column']);
    tempCount(timepxId)=[];
    obj.yname=[ynames(timepxId),ynames(tempCount)];
    obj.y=[cont.data(:,startData+timepxId-1),cont.data(:,startData+tempCount-1)];        
else
    obj.y=cont.data(:,startData:startData+3);
    obj.yname=ynames;    
end
obj.timepxId=1;
obj.dio1Id=2;
obj.dio2Id=3;
obj.dio3Id=4;


% Determine sub structure 

numDiodeMeas=round(obj.time*dioMeasurePSec);

%obj.sub.y
%obj.sub.yMean
%obj.sub.tmpxNum=0;






end


