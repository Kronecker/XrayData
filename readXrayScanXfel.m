function [cont]=readXrayScanXfel(fileFormatString, fileNum, path)


cont=struct;

    if(isnumeric(fileNum))
        fileName=sprintf(fileFormatString,fileNum);        
    elseif(ischar(fileNum))
        fileName=fileNum;
        fileNum=-1;
    else
        warning('error');
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
    timePerSub=str2double(firstLineCell{3});
    dioMeasurePSec=10;
    numDataPoints=(timePerSub)*dioMeasurePSec*3+3+2; %diodeX3 + timePix(2)
    numErrorPoints=timePerSub*dioMeasurePSec*3+1;
    preSubDataColums=[1+3+3]; % start + timex3 + meanx3
    
    % Assuming, that number of elements is always the same for all columns!
    % If that is not the case, assignment will throw an error Or miss values.
    
    dataFormatString=[repmat('%f',[1, preSubDataColums]), repmat([repmat('%f',[1, numDataPoints+numErrorPoints]),'%s'],[1,numTimePoints])];
 %   dataFormatString2=[repmat('%f',[1,numel(firstLineCell)-1]),'%s']; only for time points =1
    
    A=textscan(fid,dataFormatString);
    cont.data=cell2mat(A(1:end-1));
    cont.timestr=A{end};
    
catch me
    fclose(fid);

    rethrow(me);
end
fclose(fid);

cont.path=path;
cont.fileNum=fileNum;


end




