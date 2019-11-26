function [x] = ADWI_Modulator(txencodeddata,fsample,bitspersample)
%
%   Modulator definition. Output is delivered directly to channel
%   so the block should include all analog signal manipulation: pulse 
%   shaping, modulation and filtering. Output is an analog signal.
%
%   Output:
%   x : Transmitter output 
%

x=txencodeddata;
