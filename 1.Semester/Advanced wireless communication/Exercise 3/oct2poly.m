function [ output_args ] = oct2poly( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
output_args = dec2bin(base2dec(num2str(input_args), 8));

