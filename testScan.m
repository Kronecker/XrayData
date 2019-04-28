%%

fidRead=fopen('sampleData\scan0126.dat');
fidToWrite=fopen('data\scan0127.dat','w');

%%

            fprintf(fidToWrite,'%s\r\n', fgetl(fidRead));
            disp('line printed');

%%

fclose(fidToWrite);
fclose(fidRead);
