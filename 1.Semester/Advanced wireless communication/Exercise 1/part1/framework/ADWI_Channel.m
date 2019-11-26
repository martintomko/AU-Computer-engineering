function [x] = ADWI_Framework_Channel(txsignal,fsample,bitspersample)
%
%   Channel definition. Output is delivered to receiver
%   so the block should include all channel effects: noise,
%   interference and fading. Output is an analog signal.
%
%   Output:
%   x : Channel output.
%

%x=txsignal;

delayProfile =   [0.3    0.4;
                   0.35   0.2;
                   0.4    0.1;
                   0.45   0.1;
                   0.8    0.04;];
freq = 44100; %frequency         
period = 1/freq; %period
impulseResponse = zeros(1,1/period);
impulseResponse( round(delayProfile(:,1).*freq) ) = delayProfile(:,2);

x = filter(impulseResponse,1,txsignal)./sum(delayProfile(:,2));



