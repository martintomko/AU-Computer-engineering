delayProfile =   [0.3    0.4;
                   0.35   0.2;
                   0.4    0.1;
                   0.45   0.1;
                   0.8    0.04;];
freq = 44100; %frequency         
period = 1/freq; %period

%%% Part 1
disp("PART 1")

%% a)
disp("a) Determine the channel transfer function Hc(f) associated with this delay profile. Plot |Hc(f)|")

% Creating impulse response

% time is irrelevant (time = 1) 
L = freq; % Length of signal
freqIndexes = round(delayProfile(:,1)/period);
amplitude(freqIndexes) = delayProfile(:,2);
t = 0:1/freq:1-1/freq; %split the range in equal parts - Time vector

% find frequency components of signal (time -> frequency)
Hc = fft(amplitude); % Frequency response, time to frequency domain
f = freq*(0:(L/2))/L; % Creating freqency array  - (Nyquist) 
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

