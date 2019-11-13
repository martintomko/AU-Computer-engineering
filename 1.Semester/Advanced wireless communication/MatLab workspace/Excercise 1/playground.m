[y Fs]=audioread('SoundMessage.wav');
delayProfile = [300 0.4; 350 0.2; 400 0.1; 450 0.1; 800 0.04;];
plot(y)

delayProfile(2)