
%% Automate Frequency Change
freq=195.102;
for freqloop=1:1:25
    freq=freq-.002
    setPPCLcoarse(12.9,freq)
    pause(10); %wait long enough for power to stabilize
    disp('Taking measurements');
    %SpectrumAnalyzer(freq)
    SpectrumAnalyzer_50GHz(freq)
end
    disp('Turning off laser');
    turnOffPPCL()


