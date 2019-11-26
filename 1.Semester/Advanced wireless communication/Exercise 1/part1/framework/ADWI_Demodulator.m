function [x] = ADWI_Demodulator(rxsignal,fsample,bitspersample)
%
%   Demodulator definition. Output is delivered directly to deocoder.
%   The block ouputs a serialized bit stream representing an estimate of
%   the TxEncodedData.
%
%   Output:
%   x : Decoder output 
%

x=rxsignal;