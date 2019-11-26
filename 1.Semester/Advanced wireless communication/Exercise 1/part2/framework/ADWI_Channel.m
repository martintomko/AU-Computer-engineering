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

delayProfile =   [0.000001    0.5;
                       0.000007    0.3;
                       0.00001     0.2;
                       0.000015    0.1;
                       0.00002     0.1;];
                   
freq = fsample; %frequency         
period = 1/freq; %period

%% Create delay profile response impulse
impulseResponse = zeros(1,1/period);
impulseResponse( round(delayProfile(:,1).*freq) +1 ) = delayProfile(:,2);


%% Filter delay profile respone from impulse
x = filter(impulseResponse,1,txsignal)./sum(delayProfile(:,2));

% add noise
x = awgn(x,15,'measured');


