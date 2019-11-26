delayProfile =   [0.3    0.4;
                   0.35   0.2;
                   0.4    0.1;
                   0.45   0.1;
                   0.8    0.04;];
carrierFreq = 2.4*10^9;
carriedPeriod = 1/carrierFreq;
freq = 44100;
period = 1/freq;



%% b)
% Zero Forcing filter
% Create impulse response for delay profile
time = max(delayProfile(:,1))+period;

filterNumTabs = round(time/period);

impulseResponse = zeros(1,filterNumTabs);
impulseResponse( round(delayProfile(:,1)./period) + 1 ) = delayProfile(:,2);

Hc = fft(impulseResponse);
HcZf = 1./Hc;
bCoefs = ifft(HcZf);
semilogx(abs(HcZf))
xlim([0 3.5*10^5])
ylim([1 6])
title('Frequency Response of Equalizer')
xlabel('f (Hz)')
ylabel('| Hc(f) |')

% Filter the Rx signal
RxFiltered = filter(bCoefs,1,RxMessage);

playerNotFiltered = audioplayer(RxMessage,freq);
playerFiltered = audioplayer(RxFiltered,freq);

play(playerFiltered)

%% c)

% Noise after filtering is much louder than without filtering.

%% d)
%Delays are introduced or incorectly reduced

