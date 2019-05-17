function [ t ] = readFile(varargin)
%readFile readsFile from Kais XrayScan for Xfel and creates XrayData tect
%from it
% [ XrayData ] = readFile(fileFormatString, fileNum, path)
% [ XrayData ] = readFile(fileName, path)
narginchk(2,3);



% Props
timepxName='Timepix';
timePxCols=2;

dioMeasurePSec=10;  % additional Def in readXrayScanXfel
startData=1+1+3;  % start + x + timex3




% Fetch Data
try
        cont=readXrayScanXfel(varargin{:});
catch me
    rethrow(me);    
end






t=XrayData();

% Convert to t
t.fileName=cont.fileName;
t.fileNum=cont.fileNum;
t.path=cont.path;
t.timestr=cont.timestr;

t.x=cont.data(:,1);

t.time=cont.data(1,2);
t.subtime=cont.data(1,3);
t.timepoints=cont.data(1,4);

t.xname=cont.header{1};

% Determine structure of mean values
ynames=cont.header(5:8);
tempCount=[1:numel(ynames)];
timepxId=tempCount(strcmp(ynames,timepxName));

offs=0;
% Sort mean values, timepx to the front
if(isempty(timepxId))
    warning(['Could not find ',timepxName,' data, adding zeros instead! Pls check names.']);
    t.yname=[{timepxName},ynames];
    t.y=[zeros([1,size(cont.data,1)]),cont.data(:,startData:startData+2)];
    offs=-1;
elseif(timepxId~=1)
    %warning(['Putting timepx data to the first column']);
    tempCount(timepxId)=[];
    t.yname=[ynames(timepxId),ynames(tempCount)];
    t.y=[cont.data(:,startData+timepxId-1),cont.data(:,startData+tempCount-1)];
else
    t.y=cont.data(:,startData:startData+3);
    t.yname=ynames;
end
t.timepxId=1;
t.dio1Id=2;
t.dio2Id=3;
t.dio3Id=4;


% Determine sub structure


t.sub.y=cont.data;
%t.sub.yMean
%t.sub.tmpxNum=0;




    t.scanstruct.numTimePoints = cont.numTimePoints;
    t.scanstruct.numErrorPoints = cont.numErrorPoints;
    t.scanstruct.numDataPoints = cont.numDataPoints;
    t.scanstruct.subtime = cont.subtime;
    t.scanstruct.dioMeasurePSec = cont.dioMeasurePSec;
    t.scanstruct.numMeanPoints=cont.numMeanPoints;
end


