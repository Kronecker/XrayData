path='data\';
fileNum=126;
fileFormatString='scan%04d.dat';
detector='timepx'; %timepx, dio1, dio2, dio3
figStart=111;



scanEta=readFile(fileNum, path, fileFormatString );
figure(figStart);
plot(scanEta.x, scanEta.(detector));




























