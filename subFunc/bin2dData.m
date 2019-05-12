function [binnedData]=bin2dData(data, binSize)
% [binnedData]=bin2dData(data, binSize)

% non-centered bin. (end,end) boundaries are averaged

firstDim=size(data,1);
secDim=size(data,2);
binnedData=zeros([ceil(firstDim/binSize),ceil(secDim/binSize),1]);


for k=1:binSize:firstDim
    for l=1:binSize:secDim
        if(k+binSize-1<=firstDim && l+binSize-1<=secDim)
            binnedData(floor(k/binSize)+1,floor(l/binSize)+1,1)=sum(sum(data(k:k+binSize-1,l:l+binSize-1)))/binSize.^2;
        else
            sumi=0;
            if(k+binSize-1>firstDim && l+binSize-1>secDim)
                corBinKRun=k:firstDim;
                corBinLRun=l:secDim;
                numOfData=(firstDim-k+1)*(secDim-l+1);
            elseif(k+binSize-1>firstDim)
                corBinKRun=k:firstDim;
                corBinLRun=l:l+binSize-1;
                numOfData=(firstDim-k+1)*binSize;
            else
                corBinKRun=k:k+binSize-1;
                corBinLRun=l:secDim;
                numOfData=(secDim-l+1)*binSize;
            end
            for corBinK=corBinKRun
                for corBinL=corBinLRun
                    sumi=sumi+data(corBinK,corBinL);
                end
            end
            
            binnedData(floor(k/binSize)+1,floor(l/binSize)+1,1)=sumi/numOfData;
        end
        
    end
end

binnedData=binnedData(:,:,1);
end
%%
% % end 1
% for k=firstDim:-binSize:1
%     for l=1:binSize:secDim
%         if(k-binSize+1>0 && l+binSize-1<=secDim)
%             binnedData(floor(k/binSize)+1,floor(l/binSize)+1,2)=sum(sum(data(k-binSize+1:k,l:l+binSize-1)))/binSize.^2;
%         else
%
%             sumi=0;
%             if(k+binSize-1>firstDim && l+binSize-1>secDim)
%                 corBinKRun=k:firstDim;
%                 corBinLRun=l:secDim;
%                 numOfData=(firstDim-k+1)*(secDim-l+1);
%             elseif(k+binSize-1>firstDim)
%                 corBinKRun=k:firstDim;
%                 corBinLRun=l:l+binSize-1;
%                 numOfData=(firstDim-k+1)*binSize;
%             else
%                 corBinKRun=k:k+binSize-1;
%                 corBinLRun=l:secDim;
%                 numOfData=(secDim-l+1)*binSize;
%             end
%             for corBinK=corBinKRun
%                 for corBinL=corBinLRun
%                     sumi=sumi+data(corBinK,corBinL);
%                 end
%             end
%
%             binnedData(floor(k/binSize)+1,floor(l/binSize)+1,1)=sumi/numOfData*binSize.^2;
%         end
%
%     end
% end

