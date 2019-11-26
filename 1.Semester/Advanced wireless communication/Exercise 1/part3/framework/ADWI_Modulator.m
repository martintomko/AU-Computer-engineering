function [x] = ADWI_Modulator(txencodeddata,fsample,bitspersample)
%
%   Modulator definition. Output is delivered directly to channel
%   so the block should include all analog signal manipulation: pulse 
%   shaping, modulation and filtering. Output is an analog signal.
%
%   Output:
%   x : Transmitter output 
%

% Due to the calculations of exercise 1 part 2 (e)
% We can stay in the baseband model and simulate the 
% effects of the modulation by:



% Convert signal to binary vectors
txencodeddata = typecast(txencodeddata,'uint16');
binSingal = de2bi(double(txencodeddata),bitspersample);
binVector = reshape(binSingal',1,[]);
% Modulate signal
x = pskmod(binVector,2);
