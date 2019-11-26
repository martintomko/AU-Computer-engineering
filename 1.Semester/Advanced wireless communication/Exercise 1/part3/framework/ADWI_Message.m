function [dataSample,sampleRate,nBits] = ADWI_Message()
% Actual Message data definition. Here,
% data can be read or otherwise generated.
% 
%Output:
%x : Vector containing message data
%y:  Message Sample Rate
%z:  No. of bits per message

[dataSample sampleRate]=audioread('SoundMessage.wav','native');
info = audioinfo('SoundMessage.wav');
nBits = info.BitsPerSample;
