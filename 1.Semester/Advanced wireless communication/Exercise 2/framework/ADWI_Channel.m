function [x,delayProfile] = ADWI_Framework_Channel(txsignal,fsample,BitsPerMessage)
%
%   Channel definition. Output is delivered to receiver
%   so the block should include all channel effects: noise,
%   interference and fading. Output is an analog signal.
%
%   Output:
%   x : Channel output.


%% Channel Delay Profile

delayProfile =   [0.3    0.4;
                  0.4    0.1;
                  0.45   0.1;
                  0.8    0.04;];
               
               
delayProfilele = [0.25    0.4;
                  0.37   0.2;
                  0.38    0.15;
                  0.40   0.15;
                  0.55    0.04;];

delayProfile = delayProfilele;
freq = fsample;
n_upsample = 0;
%% Upsampling of Signal to fit delay profile (Baseband model)
% Upsampled frequency needed and number of samples introduced pr upsample 
f_upsample = 1/0.05;

if(f_upsample > fsample)
    freq = f_upsample;
    %f_upsample = max(delay_profile(:,1).^-1);
    n_upsample = ceil(freq/fsample);

    % Upsample the signal
    txsignal = upsample(txsignal,n_upsample);

    % Staircase upsampling
    % upsampling introduces 0s for every new sample introduced
    % to make staircase upsampling we can filter the signal with an impulse response window.
    upsample_impulse = ones(1,n_upsample);

    % Perform upsampling filtering on the signal
    txsignal = filter(upsample_impulse,1,txsignal);
end
%% Delay spread filtering
% Create impulse response for delay profile
period = 1/freq;
time = max(delayProfile(:,1))+period;
filterNumTabs = round(time/period);

impulseResponse = zeros(1,filterNumTabs);
impulseResponse( round(delayProfile(:,1)./period) + 1 ) = delayProfile(:,2);


% Filter the signal
%x = conv(impulse_response,txsignal);
x = filter(impulseResponse,1,txsignal)./sum(delayProfile(:,2));


%% Add AWGN from the channel
%x = awgn(x,40,'measured');

%% Downsample the signal
% Only choose mathced part of signal

% Downsample to original sample frequency
if n_upsample > 0
    x = downsample( x , n_upsample); 
end

