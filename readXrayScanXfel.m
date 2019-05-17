function [cont]=readXrayScanXfel(varargin)
%readXrayScanXfel Reads Kais XrayScan for Xfel
% [dataStruct]=readXrayScanXfel(fileFormatString, fileNum, path)
% [dataStruct]=readXrayScanXfel(fileName, path)
narginchk(2,3);

cont=struct;


if(nargin==3)
    fileFormatString=varargin{1};
    fileNum=varargin{2};
    path=varargin{3};
    if(isnumeric(fileNum))
        fileName=sprintf(fileFormatString,fileNum);
    elseif(ischar(fileNum))
        fileName=fileNum;
        fileNum=[];
    else
        warning('error');
    end
elseif(nargin==2)
    fileName=varargin{1};
    path=varargin{2};
    fileNum=[];
end


cont.fileName=fileName;
cont.path=path;
cont.fileNum=fileNum;

fileExists=exist(fullfile(path,fileName),'file');
if(fileExists~=2) % file not found
    if(fileExists==7)  % file does not exist, but a folder
        fprintf('File was not found, however a directory with the same name was. Pls check the specified path and name and try again.\n%s\n'...
            ,fullfile(path,fileName));
        error('File not found');
    else
        fprintf('File was not found. Pls check the specified path and name and try again.\n%s\n'...
            ,fullfile(path,fileName));
        error('File not found');
    end
    
    return; % get the f out of here
end


fid=fopen(fullfile(path,fileName),'r');
try
    header=fgetl(fid);
    cont.header=strsplit(header,'\t');
    startFirstDataLine=ftell(fid);
    firstLine=fgetl(fid);
    fseek(fid,startFirstDataLine,-1);
    firstLineCell=strsplit(firstLine,'\t');
    
    numTimePoints=str2double(firstLineCell{4});
    subtime=str2double(firstLineCell{3});
    dioMeasurePSec=10;
    numMeanPoints=4;
    numDataPoints= subtime*dioMeasurePSec*3; % meanx4 + subtime*3diode
    
    numErrorPoints=subtime*dioMeasurePSec*3;
    preSubDataColums=[1+3+4]; % start + timex3 + meanx4
    
    % Assuming, that number of elements is always the same for all columns!
    % If that is not the case, assignment will throw an error Or miss values.
    
    dataFormatString=[repmat('%f',[1, preSubDataColums]),  repmat(  repmat('%f',[1, numMeanPoints+numDataPoints+numErrorPoints]) , [1,numTimePoints]  )    '%s'];
    %   dataFormatString2=[repmat('%f',[1,numel(firstLineCell)-1]),'%s']; only for time points =1
    
    A=textscan(fid,dataFormatString);
    cont.data=cell2mat(A(1:end-1));
    cont.timestr=A{end};
    cont.numTimePoints=numTimePoints;
    cont.numErrorPoints=numErrorPoints;
    cont.numDataPoints=numDataPoints;
    cont.numMeanPoints=numMeanPoints;
    cont.subtime=subtime;
    cont.dioMeasurePSec=dioMeasurePSec;
    
    
catch me
    fclose(fid);
    
    rethrow(me);
end
fclose(fid);

cont.path=path;
cont.fileNum=fileNum;


end




