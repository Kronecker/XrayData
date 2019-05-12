classdef XrayData < handle
    %XRAYDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fileName
        x
    end
    properties (Dependent)
        timepx % test
        dio1 %3
        dio2
        dio3
    end
    properties
        y
        time
        subtime
        timepoints
        timeIsNormalized=0
    end
    properties (Hidden)
        timepxId
        dio1Id  %hello there
        dio2Id
        dio3Id
    end
    properties
        sub=struct()
    end
    properties (Dependent)
        subtimepx
        subdio1
        subdio2
        subdio3
    end
    
    properties
        xname
        yname
        log
        fileNum %test2
        path
        timestr
        
        pl
        talktome=false
        
    end
    
    
    methods
        function t=XrayData()
            t.sub.y=[];
            t.sub.timepixStart=[];
            t.sub.timepixNums=[];
            t.sub.dio1Start=[];
            t.sub.dio2Start=[];
            t.sub.dio3Start=[];
            t.sub.dioNums=[];                                    
        end
        function plot(t, varargin)
            narginchk(0,2);
            legi={};
            if(nargin==1)            
                yyaxis left
                plot(t.x, t.y(:,1));
                legi(end+1)=t.yname(1);
                yyaxis right
                plot(t.x, t.y(:,2:4));
                legi(end+1:end+3)=t.yname(2:4);
                legend(legi);
                yyaxis left
            elseif (nargin==2)
                if(ischar(varargin{1}))  %|| isstring(varargin{1})
                    plot(t.x, t.(varargin{1}));
                    legend(varargin{1});
                elseif (isnumeric(varargin{1}))
                    
                    plot(t.x, t.y(:,varargin{1}));                    
                    legend(t.yname(varargin{1}));
                end
            else
                
                
            end
            
        end
        function [data, time, subtime, timepoints,timestr]=extract(t)
            data=[t.x,t.y];
            time=t.time;
            subtime=t.subtime;
            timepoints=t.timepoints;
            timestr=t.timestr;                                               
        end
        function normalize(t, detector)
            if(isnumeric(detector))
                t.y=t.y./repmat(t.y(:,detector),[1,size(t.y,2)]);
            elseif ischar(detector)
                t.y=t.y./repmat(t.(detector),[1,size(t.y,2)]);
            end
        end
        function fit(t)
            
        end
        function getData(t)
            
        end
        
        function getNumFromName(t,endPre, startPost)
            
            
        end
        
        % GET/SET Methods for dependent props
        function y=get.timepx(t)
            y=t.y(:,t.timepxId);
        end
        function y=get.dio1(t)
            y=t.y(:,t.dio1Id);
        end
        function y=get.dio2(t)
            y=t.y(:,t.dio2Id);
        end
        function y=get.dio3(t)
            y=t.y(:,t.dio3Id);
        end
        function set.timepx(t,val)
            t.y(:,t.timepxId)=val;
        end
        function set.dio1(t,val)
            t.y(:,t.dio1Id)=val;
        end
        function set.dio2(t,val)
            t.y(:,t.dio2Id)=val;
        end
        function set.dio3(t,val)
            t.y(:,t.dio3Id)=val;
        end
        function addlog(t,logFile)
            
        end
        function normalizeTime(t)
            t.y=t.y/t.time;
            t.timeIsNormalized=1;
        end
    end
    methods (Static)
        function help()
            props=properties('XrayData');
            for k=1:numel(props)
                help(sprintf('XrayData.%s',props{k}));
                
            end
     
        end
        
    end
end

