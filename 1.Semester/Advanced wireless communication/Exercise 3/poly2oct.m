function [ output_args ] = poly2oct( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[m, n] = size(input_args);
for i = 1:m
    decimal_value = bin2dec(num2str(input_args(i,:)));
    octal_base = dec2base(decimal_value,8);
    output_args(i) = str2num(octal_base);
end

