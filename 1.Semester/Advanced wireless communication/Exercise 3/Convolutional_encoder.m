function [ non_systematic_message, systematic_message, dfree] = Convolutional_encoder( G_trans, input_message, puncture_pattern)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(G_trans);
K = zeros(1,m);

for i=1:m
    for k=1:n
    [h,j,x]= find(oct2poly(G_trans(i,k)));%  j contains the element column number not containing '0'
        if K(i) < max(j)
            K(i)=max(j)-1;
        end
    end
end

trellis_non_systematic = poly2trellis([K+1],G_trans);
if(m==1)
    trellis_systematic = poly2trellis([K+1], G_trans, G_trans(1,1));
    if nargin < 3
        systematic_message = convenc(input_message,trellis_systematic);
    else
        systematic_message = convenc(input_message,trellis_systematic,puncture_pattern);
    end
end

spect = distspec(trellis_non_systematic);
dfree = spect.dfree;

    if nargin < 3
        non_systematic_message = convenc(input_message,trellis_non_systematic);
    else
        non_systematic_message = convenc(input_message,trellis_non_systematic,puncture_pattern);
    end
end

