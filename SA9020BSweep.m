function SA9020BSweep(freqloop)
numTrace=30;

%Names the data File_1...File_30

% Connect steps
clear SCPI_90x0_SA;
SCPI_90x0_SA = tcpip('169.254.144.85', 5025);
SCPI_90x0_SA.InputBufferSize = 8388608;
SCPI_90x0_SA.ByteOrder = 'littleEndian';
fopen(SCPI_90x0_SA);

% Setup Spectrum Analyzer
fprintf(SCPI_90x0_SA, sprintf(':INITiate:CONTinuous %d', 1));
fprintf(SCPI_90x0_SA, sprintf(':SENSe:FREQuency:STARt %g', 0.0));
fprintf(SCPI_90x0_SA, sprintf(':SENSe:FREQuency:STOP %g', 27000000000.0));
fprintf(SCPI_90x0_SA, sprintf(':SENSe:BANDwidth:RESolution %g', 5000000.0));
fprintf(SCPI_90x0_SA, sprintf(':SENSe:BANDwidth:VIDeo %g', 5000000.0));

for t=1:2
    name=(freqloop*numTrace)-numTrace+t;
    filename= sprintf('File_%s',num2str(name));
    fprintf(SCPI_90x0_SA, sprintf(':MMEMory:STORe:TRACe:DATA %s, "%s"', 'TRACE1', filename));
    pause(2);
end

disp('Measurement completed');

% Cleanup
fclose(SCPI_90x0_SA);
delete(SCPI_90x0_SA);
clear SCPI_90x0_SA;

end