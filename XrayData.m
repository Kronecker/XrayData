classdef XrayData < handle
    %XRAYDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fileName
        x
    end
    properties (Dependent)
        timepx
        dio1
        dio2
        dio3
    end
    properties
        y
        time
        subtime
        timepoints
    end
    properties (Hidden)
        timepxId
        dio1Id
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
        fileNum
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
        function help(t)
            
        end
        function plot(t)
            yyaxis left
            plot(t.x, t.y(:,2:4));
            yyaxis right
            plot(t.x, t.y(:,1));
        end
        function extract(t)
            
        end
        function normalize(t)
            
        end
        function fit(t)
            
        end
        function getData(t)
            
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
    end
    
end

