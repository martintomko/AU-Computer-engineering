function [y,Fs,nbits] = ADWI_Message()
% Actual Message data definition. Here,
% data can be read or otherwise generated.
% 
%Output:
%x : Vector containing message data
%y:  Message Sample Rate
%z:  No. of bits per message

[y Fs]=audioread('SoundMessage.wav');
nbits = length(y);

