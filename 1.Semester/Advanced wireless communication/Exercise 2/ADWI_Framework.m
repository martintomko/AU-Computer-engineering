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


%% Bit error rate (BER)
size(TxEncodedData)
size(RxEncodedData)
BitErrorVector=xor(TxEncodedData,RxEncodedData);
BER=sum(BitErrorVector)/length(TxEncodedData)
