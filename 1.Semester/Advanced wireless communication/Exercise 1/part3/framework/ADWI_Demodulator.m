function [x] = ADWI_Demodulator(rxsignal,fsample,bitspersample)
%
%   Demodulator definition. Output is delivered directly to deocoder.
%   The block ouputs a serialized bit stream representing an estimate of
%   the TxEncodedData.
%
%   Output:
%   x : Decoder output 
%

% Demodulate signal
demodulatedDecimal = pskdemod(rxsignal,2);

% Convert signal to binary vectors
binDemodulator = reshape( demodulatedDecimal,16,[]);
binDemodulator = binDemodulator';
demodulatedDecimal = bi2de(uint16(binDemodulator));
x = typecast(demodulatedDecimal,'int16');
x = int16(x);
