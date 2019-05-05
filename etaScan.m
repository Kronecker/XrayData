path='data\';
fileNum=126;
fileFormatString='scan%04d.dat';
detector='timepx';

scanEta=readFile(fileNum, path, fileFormatString );
scanEta.plot();


























