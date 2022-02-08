function SpectrumAnalyzer_50GHz(freq)

% Variable declarations

% Connect steps
SCPI_N99xx_SA = tcpip('192.168.0.1', 5025);
SCPI_N99xx_SA.InputBufferSize = 8388608;
SCPI_N99xx_SA.ByteOrder = 'littleEndian';
fopen(SCPI_N99xx_SA);

% Commands
idn = query(SCPI_N99xx_SA, '*IDN?');
fprintf(SCPI_N99xx_SA, sprintf(':INITiate:CONTinuous %d', 1));
fprintf(SCPI_N99xx_SA, sprintf(':INSTrument:SELect "%s"', 'SA'));
fprintf(SCPI_N99xx_SA, sprintf(':SENSe:FREQuency:STARt %g', 0.0));
fprintf(SCPI_N99xx_SA, sprintf(':SENSe:FREQuency:STOP %g HZ', 50000000000.0));
fprintf(SCPI_N99xx_SA, sprintf(':SENSe:POWer:RF:ATTenuation:AUTO %d', 0));
fprintf(SCPI_N99xx_SA, sprintf(':SENSe:POWer:RF:ATTenuation %g', 0));
fprintf(SCPI_N99xx_SA, sprintf(':SENSe:BANDwidth:RESolution:AUTO %d', 0));
fprintf(SCPI_N99xx_SA, sprintf(':SENSe:BANDwidth:RESolution %g MHZ', 5.0));
fprintf(SCPI_N99xx_SA, sprintf(':SENSe:BANDwidth:VIDeo:AUTO %d', 0));
fprintf(SCPI_N99xx_SA, sprintf(':SENSe:BANDwidth:VIDeo %g MHZ', 5.0));


for i=1:1:20
    filename= sprintf('Freq_%s_%s',num2str(freq),num2str(i));
    fprintf(SCPI_N99xx_SA, sprintf(':MMEMory:CDIRectory "%s"', '[USBDISK]:'));
    fprintf(SCPI_N99xx_SA, sprintf(':MMEMory:STORe:FDATa "%s"',filename));
    pause(2);
end
disp('Measurement completed');
% Cleanup
fclose(SCPI_N99xx_SA);
delete(SCPI_N99xx_SA);
clear SCPI_N99xx_SA;

end
