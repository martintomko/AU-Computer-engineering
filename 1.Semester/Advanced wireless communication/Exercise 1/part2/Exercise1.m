delayProfile =   [0.000001    0.5;
                       0.000007    0.3;
                       0.00001     0.2;
                       0.000015    0.1;
                       0.00002     0.1;];
carrierFreq = 2.4*10^9; 
carrierPeriod = 1/carrierFreq;
time = 0.0004;
freq = 44100;
period = 1/freq; %period


%%% Part 2
disp("PART 2")

%% a)
disp("a) Determine the channel transfer function Hc(f) associated with this delay profile. Plot |Hc(f)|")

% Creating impulse response
L = carrierFreq*time; % Length of signal
amplitude = zeros(1,time/carrierPeriod);
freqIndexes = round(delayProfile(:,1)/carrierPeriod);
amplitude(freqIndexes) = delayProfile(:,2);
t = 0:1/freq:1-1/freq; %split the range in equal parts - Time vector

% find frequency components of signal (time -> frequency)
Hc = fft(amplitude); % Frequency response, time to frequency domain
f = carrierFreq*(0:(L/2))/L; % Creating freqency array  - (Nyquist) 
normalized = abs(Hc/L); % normalize Magnitude by bin numbers
P = normalized(1:L/2+1);

P(2:end-1) = 2*P(2:end-1);
figure(1);
fig1 = semilogx(f,P);
title('Frequency Response of Delay spread')
xlabel('f (Hz)')
ylabel('| Hc(f) |')

%% b)
disp("b) Calculate the RMS delay spread (?T) and the coherence bandwidth (B0).")
mean_delaySpread = delayProfile(:,1)'*delayProfile(:,2)/sum(delayProfile(:,2));
second_delaySpread = delayProfile(:,1).^2'*delayProfile(:,2)/sum(delayProfile(:,2));
rms_delaySpread = sqrt(second_delaySpread-mean_delaySpread^2)
multipathSpread = sqrt((delayProfile(:,1)-mean_delaySpread).^2'*delayProfile(:,2)/sum(delayProfile(:,2)));
coherenceBandwith = 1/multipathSpread

%% c)
% Updated channel file in framework

%% d)

