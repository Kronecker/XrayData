function changeListener=myFileWatch(pathToWatch)   
fileObj = System.IO.FileSystemWatcher(pathToWatch);
fileObj.EnableRaisingEvents = true;
changeListener =addlistener(fileObj, 'Changed', @onMyChange); %need to keep in scope
  
    function onMyChange(~,evt)
        pause(0.01);
        fileFormatString='scan%04d.dat';
        figure(4242);
        try 
            t=readFile(char(evt.FullPath), '',fileFormatString);
            t.plot();
            title(char(evt.Name));
        
        catch me
            warning(me.message);
        end 

    end %onChange
end %FileWatch