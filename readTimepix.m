
  %%
  fid=fopen('frame_value_12.bin');
  header=fread(fid,8,'*uint16');
  bild_bin=fread(fid,[header(5),header(7)],'*uint16');
  fclose(fid);
  figure;
  subplot(2,1,1)
  imagesc(bild_bin);
  subplot(2,1,2)
  bincounts=histc(bild_bin(:),100:200);
  plot(100:200,bincounts)
  %%
