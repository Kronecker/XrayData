function path=comma2point(File)
% Generate a new file named Oldfilename_Modified.ending. In the new File all
% ',' are changed to '.' Needs a full datapath and filename as input.

file = memmapfile(File,'Writable',true);
comma = uint8(',');
point = uint8('.');
file.Data(( file.Data==comma)' ) = point;
%delete(file)
path='';
path=file.Filename;
end 