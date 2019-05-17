% timepix unzip 
path='sampleData/sample2/';
pathForTempFiles=pwd();
scanName='scan0032t.dat';


splitname=strsplit(scanName,'.');

if(splitname{1}(end)=='t')
    splitname{1}=splitname{1}(1:end-1);    
end

tempDirName=['tmpMtlb_',splitname{1}];
mkdir(tempDirName);
tempPath=fullfile(pathForTempFiles,tempDirName);
dd=dir(path);
for k=1:numel(dd)
    if(dd(k).isdir)
        continue;
    end    
    curNameSplit=strsplit(dd(k).name,'.');
    if(~strcmp(curNameSplit{end},'zip'))
        continue;
    end
    if(strfind(dd(k).name,splitname{1}))
        unzip(fullfile(path,dd(k).name),tempPath);        
    end
end

tempPath

%% timepix read all

startAtIndex=0;
path=tempPath;
nameFormatStr='frame_value_%d.bin';

dd=dir(tempPath);

            binariesInDir=0;
            for k=1:numel(dd)
                if(dd(k).isdir) continue; end
                ext=strsplit(dd(k).name,'.');
                if(strcmp(ext{end},'bin'))
                    binariesInDir=binariesInDir+1;
                end                
            end

maxFails=5;


% 1. Try starting at zero
k=0;
fails=0;
l=1;
countTimePix=@(data) sum(sum(data(1:end,1:end)));

while(k<numel(dd))  
    
    fileName=fullfile(path,sprintf(nameFormatStr,k+startAtIndex));
    if(exist(fileName, 'file'))
        data=readTimepix(fileName);
        fails=0;
    else
        fails=fails+1;
        if(fails>=maxFails)           
           break;
        end
       % continue;
    end
    k=k+1;
    
    y(l)=countTimePix(data);
    l=l+1;
    
  %  figure(777);
  %  imagesc(data);
  %  drawnow
    
    
end









