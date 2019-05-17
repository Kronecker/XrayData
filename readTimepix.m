function [data, sz] = readTimepix (file)   % By Robert
 
  fid=fopen(file);
  try 
      header=fread(fid,8,'*uint16');
      sz=[header(5),header(7)];
      data=double(fread(fid,sz,'*uint16'));
  catch me
     fclose(fid);
     rethrow(me);
  end
  fclose(fid);
end

  %
  %figure;
  %subplot(2,1,1)
  %imagesc(bild_bin);
  %subplot(2,1,2)
  %bincounts=histc(bild_bin(:),100:200);
  %plot(100:200,bincounts)
 