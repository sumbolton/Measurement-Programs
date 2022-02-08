function SA9020B(freq,current)

% Connect steps
clear SCPI_90x0_SA;
SCPI_90x0_SA = tcpip('169.254.144.85', 5025);
SCPI_90x0_SA.InputBufferSize = 8388608;
SCPI_90x0_SA.ByteOrder = 'littleEndian';
fopen(SCPI_90x0_SA);

% Commands
%str = query(SCPI_90x0_SA, '*IDN?');
% str2 = query(SCPI_90x0_SA, ':MMEMory:CDIRectory?');
%fprintf(SCPI_90x0_SA, sprintf(':MMEMory:MOVE "%s","%s"','G:\Measurements', 'G:\0V\5GHZ'));
%fprintf(SCPI_90x0_SA, sprintf(':MMEMory:CDIRectory "%s"','G:\'));
%delfile="F" + frequency + "_" + d + ".csv";
% fprintf(SCPI_90x0_SA, sprintf(':MMEMory:COPY "%s","%s"',mdirectory, 'G:\-5V\3GHz\500\\'));

 %Create the files, then copy the files, then delete the original
fprintf(SCPI_90x0_SA, sprintf(':INITiate:CONTinuous %d', 1));
fprintf(SCPI_90x0_SA, sprintf(':SENSe:FREQuency:STARt %g', 0.0));
fprintf(SCPI_90x0_SA, sprintf(':SENSe:FREQuency:STOP %g', 27000000000.0));
fprintf(SCPI_90x0_SA, sprintf(':SENSe:BANDwidth:RESolution %g', 5000000.0));
fprintf(SCPI_90x0_SA, sprintf(':SENSe:BANDwidth:VIDeo %g', 5000000.0));

 for d=1:20
filename= sprintf('F%d_%d.csv', freq,d);
mdirectory='G:\Measurements\\';
newdirectory="G:\0V\10GHz\" + current + "\\";
fprintf(SCPI_90x0_SA, sprintf(':MMEMory:STORe:TRACe:DATA %s, "%s"', 'TRACE1', filename));
fprintf(SCPI_90x0_SA, sprintf(':MMEMory:COPY "%s","%s"',mdirectory, newdirectory));
fprintf(SCPI_90x0_SA, sprintf(':MMEMory:DELete "%s", "%s"',filename,mdirectory));
pause(1);
 end
 
% Cleanup
fclose(SCPI_90x0_SA);
delete(SCPI_90x0_SA);
clear SCPI_90x0_SA;

end
