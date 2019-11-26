function [x] = ADWI_Encoder(message,fsample,bitspersample)
%   Encoder definition. Output is delivered directly to modulator
%   so the block should include message encoding, encryption 
%   and channel coding. Output is a serialized bit stream.
%
%   Output:
%   x : Encoded bit stream

x=message;
