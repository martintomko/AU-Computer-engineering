function [x,delayProfile] = ADWI_Framework_Channel(txsignal,fsample,BitsPerMessage)
%
%   Channel definition. Output is delivered to receiver
%   so the block should include all channel effects: noise,
%   interference and fading. Output is an analog signal.
%
%   Output:
%   x : Channel output.
%
%% Choose Channel Parameters
% Choose the delay profile from exercise part 1, 2 or 3
% Noise parameters
with_noise = 1;
snr_value = 8;

%% Channel Delay Profile
delayProfile =[50 * 10^(-9)     0.5;
                100 * 10^(-9)    0.5;
                200 * 10^(-9)    0.4;
                350 * 10^(-9)    0.5;
                600 * 10^(-9)    0.8;
                800 * 10^(-9)    0.6];

fsample = fsample * BitsPerMessage;
freq = fsample;
n_upsample = 0;
%% Upsampling of Signal to fit delay profile (Baseband model)
% Upsampled frequency needed and number of samples introduced pr upsample 
f_upsample = 50 * 10^(-9);

if(f_upsample > fsample)
    freq = f_upsample;
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
ts = 1/freq;
time = max(delayProfile(:,1))+ts;
filter_num_tabs = round(time/ts);

impulse_response = zeros(1,filter_num_tabs);
impulse_response( round(delayProfile(:,1)./ts) + 1 ) = delayProfile(:,2);


% Filter the signal
x = filter(impulse_response,1,txsignal)./sum(delayProfile(:,2));


%% Add AWGN from the channel
if with_noise == 1
    x = awgn(x,snr_value,'measured');
end
%% Downsample the signal
% Only choose mathced part of signal

% Downsample to original sample frequency
if n_upsample > 0
    x = downsample( x , n_upsample); 
end

