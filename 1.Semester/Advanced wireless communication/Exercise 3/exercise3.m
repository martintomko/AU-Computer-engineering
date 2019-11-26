
%% a) Make convolutional encoder and apply it on random binary msg stream
 
% Conv encoder explained:
% https://www.youtube.com/watch?v=L_1qDvOVQCs

k = 1; % number of bits per stage
K = 2; % number of shift register stages
n = 2; % binary addition operators win inputs taken all K stages
constraintLength = k+K;
%codeRate = k/n;
% produced codewords
C1 = [1 1 1]; 
C2 = [1 0 1];

%Make random stream of binary data
msg = round(rand(1,10000));

% Create conv_encoder model
codeGenerator = [bin2oct(C1) bin2oct(C2)];
convTrellisModel = poly2trellis(constraintLength,codeGenerator);


%apply message to conv_encoder model
convResult = convenc(msg,convTrellisModel);

%% b) Create viterbi decoder and apply it on encoded msg from a)

% if the codeRate is 1/2 (k/n) then typical values is above 5 times of constrainthLength of the code 
tracebackDepth = constraintLength*5; %15

decodedMsg = vitdec(convResult,convTrellisModel,tracebackDepth,'trunc','hard');

BitErrorVector=xor(msg,decodedMsg);
BER=sum(BitErrorVector)/length(msg);

%% c) and d) simulate errors in received msg and decode it

%Simulate error in first bit
convResultError = convResult;

errorNum = 2;
for i=1:errorNum
    convResultError(i) = 1 - convResultError(i);
end

decodedMsgWithFix = vitdec(convResultError,convTrellisModel,tracebackDepth,'trunc','hard');

% after small testing we found out can fix 2 errors at most.
% error correction capabilty is 2 bits in windwos of 6 bits
% formula: (dFree-1)/2

%compare original msg with msg after decoding (including error)
BitErrorVector=xor(msg,decodedMsgWithFix);
BER=sum(BitErrorVector)/length(msg);


function [ out ] = bin2oct( input )

    [m, n] = size(input);
    for i = 1:m
        dec = bin2dec(num2str(input(i,:)));
        octa = dec2base(dec,8);
        out(i) = str2num(octa);
    end
end

