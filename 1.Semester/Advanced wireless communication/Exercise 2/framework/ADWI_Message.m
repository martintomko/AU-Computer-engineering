function [dataSample,sampleRate,nBits] = ADWI_Message()
% Actual Message data definition. Here,
% data can be read or otherwise generated.
% 
%Output:
%dataSample : Vector containing message data
%sampleRate:  Message Sample Rate
%nBits:  No. of bits per message

[dataSample sampleRate]=audioread('SoundMessage.wav');
info = audioinfo('SoundMessage.wav');
nBits = info.BitsPerSample;

