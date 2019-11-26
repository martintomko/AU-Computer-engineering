function [x,profile] = ADWI_Framework_Channel(txsignal,fsample,BitsPerMessage)
%
%   Channel definition. Output is delivered to receiver
%   so the block should include all channel effects: noise,
%   interference and fading. Output is an analog signal.
%
%   Output:
%   x : Channel output.
%

%% Channel Delay Profile

delay_profile =   [0.3    0.4;
                   0.35   0.2;
                   0.4    0.1;
                   0.45   0.1;
                   0.8    0.04;];
               
adjusted_delay_profile =   [0.25    0.4;
                            0.39   0.2;
                            0.4    0.15;
                            0.45   0.15;
                            0.7    0.04;]; 
delay_profile = adjusted_delay_profile;
profile = delay_profile;
%% Upsampling of Signal to fit delay profile (Baseband model)
% Upsampled frequency needed and number of samples introduced pr upsample 
f_upsample = max(delay_profile(:,1).^-1);
n_upsample = ceil(f_upsample/fsample);
f_upsample=fsample;
% Plot of part of the signal to be upsampled
% f5 = figure(5);
% movegui(f5,'southwest')
% subplot(3,1,1)
% plot(txsignal(300:310))
% title('Part of signal to be upsampled')
% xlabel('Sample count')

% Upsample the signal
%txsignal = upsample(txsignal,n_upsample);

% plot of upsampled signal
% figure(5);
% subplot(3,1,2)
% plot(txsignal(300*n_upsample:310*n_upsample))
% title('Upsampled part signal')
% xlabel('Sample count')

%% Staircase upsampling
% upsampling introduces 0s for every new sample introduced
% to make staircase upsampling we can filter the signal with an impulse response window.
%upsample_impulse = ones(1,n_upsample);

% Plot of upsample impulse response to create staircase
% figure(6);
% subplot(2,1,1)
% stem(upsample_impulse)
% title('Upsampling impulse response (create stair sampling)')

% Perform upsampling filtering on the signal
%txsignal = filter(upsample_impulse,1,txsignal);

% Plot of staircase upsampled signal
% figure(5);
% subplot(3,1,3)
% plot(txsignal(300*n_upsample:310*n_upsample))
% title('Perform stair upsampling')
% xlabel('Sample count')

%% Delay spread filtering
% Create impulse response for delay profile
ts = 1/f_upsample;
time = max(delay_profile(:,1))+ts;
filter_num_tabs = round(time/ts)

impulse_response = zeros(1,filter_num_tabs);
impulse_response( round(delay_profile(:,1)./ts) + 1 ) = delay_profile(:,2);

%Plot impulse reponse of filter next to staircase impulse respnse
 %f6 = figure(6);
 %movegui(f6,'southeast')
 %subplot(2,1,2)
 %stem(impulse_response)
 %title('Channel delay spread')

% Filter the signal
x = conv(impulse_response,txsignal);

% plot filtered signal
% figure(7);
% plot(x)
% title('Channel Filtered Signal')

%% Add AWGN from the channel
 %x = awgn(x,40,'measured'); % First part of exercise 2 awgn must not be
% applied
%% Downsample the signal
x = x(filter_num_tabs/2:end-filter_num_tabs/2);

