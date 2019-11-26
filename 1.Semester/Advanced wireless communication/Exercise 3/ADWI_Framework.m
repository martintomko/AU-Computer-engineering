close all
%% System model:
[TxMessage MessageSampleRate BitsPerMessage]=ADWI_Message();
[TxEncodedData]=ADWI_Encoder(TxMessage,MessageSampleRate,BitsPerMessage);
[TxSignal]=ADWI_Modulator(TxEncodedData,MessageSampleRate,BitsPerMessage);
[RxSignal, ChannelProfile]=ADWI_Channel(TxSignal,MessageSampleRate,BitsPerMessage);
[RxEncodedData]=ADWI_Demodulator(RxSignal,MessageSampleRate,BitsPerMessage);
[RxMessage]=ADWI_Decoder(RxEncodedData,MessageSampleRate,BitsPerMessage);

%% Playback reconstructed message:
player = audioplayer(RxMessage,MessageSampleRate);
play(player)

%% Various manipulations and presentations
f1 = figure(2);
movegui(f1,'northwest')
subplot(4,1,1);
plot(real(TxMessage)) 
title('Message')

subplot(4,1,2);
plot(real(TxSignal));
title('Tx Signal')

subplot(4,1,3);
plot(real(RxSignal));
title('Rx Signal')

subplot(4,1,4);
plot(real(RxEncodedData));
title('Demodulated Signal')

%% Align Tx and Rx signals to allow for calculation of BER
% Care reguarding modulation. Offset modulated signals contains bad data in
% the end of the signal
%RxEncodedData = [RxEncodedData(ChannelProfile(1,1)*MessageSampleRate:end)];
%diff = length(RxEncodedData)-length(TxEncodedData);
%TxEncodedData = [TxEncodedData; zeros(diff,1)];

%% Plots after allignment
f3 = figure(3);
movegui(f3,'northeast')
subplot(2,1,1);
plot(TxMessage);
title('Send Message')

subplot(2,1,2);
plot(RxMessage);
title('Received Message')

%% Bit error rate (BER)
size(TxEncodedData)
size(RxEncodedData)
BitErrorVector=xor(TxEncodedData,RxEncodedData);
BER=sum(BitErrorVector)/length(TxEncodedData)
