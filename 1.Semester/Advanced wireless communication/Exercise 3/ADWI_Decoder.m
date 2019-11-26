function [x] = ADWI_Decoder(RxEncodedData,fsample,bitspersample)
%
%   Decoder definition. Output is a reconstruction of the original message
%   signal. The block should include: channel decoding and source 
%   decryption and decoding.
%
%   Output:
%   x : Reconstructed Message 
%

x=RxEncodedData;