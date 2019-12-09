%% intro
%Generate random stream of binary data
msg = round(rand(1,1000));

%Given values
gainVoltsdB = 20;
gainVolts = 10^(gainVoltsdB/20);
secondOrderIPdBm = 20;
secondOrderIP = db2pow(secondOrderIPdBm)*10^-3; % converts from dBm to watts
thirdOrderIPdBm = 10;
thirdOrderIP = db2pow(thirdOrderIPdBm)*10^-3; % converts from dBm to watts

syms Xin
% find Xin
eq = 20*log10(Vout1Order(Xin, gainVolts)/Voutt(Xin, gainVolts, secondOrderIP, thirdOrderIP)) == 1;

%The equation is then  solved with respect to 
res = double( solve(eq,Xin) )

%The result is in Watts so we need to converts back to dBm
solutions = pow2db(res.^2 / 10^-3 )
P1dBm = solutions(1)

%Find P3iip - third order intercept point
% in non-linear amplifier the third term relates to linearly amplified
% signal which is first order term for us
eq = Vout1Order(Xin,gainVolts) == Vout3Order(Xin,gainVolts,thirdOrderIP);
%The equation is then  solved with respect to 
res = double( solve(eq,Xin) )
%The result is in Watts, so we need -> dBm
solutions = pow2db(res.^2 / 10^-3 )
P3IIPdBm = max(solutions);

P1_P3Diff = P3IIPdBm - P1dBm

% apply bpsk modulator on data
bpskModulator = comm.BPSKModulator;
bpskData = bpskModulator(msg');


%% function definitions
% Amplifier Output - define models
% Formula rewritten from exercise 4 - (Equation 6.1)
function [ out ] = Voutt( Vin,Gv, IP2, IP3 ) % 1. order
    out = Gv*Vin + sqrt(2)/IP2*Vin.^2 - 2/3*Gv/IP3*Vin.^3;
end

%split Vout into orders
function [ out ] = Vout1Order( Vin,Gv ) % 1. order
    out = Gv*Vin;
end
function [ out ] = Vout3Order( Vin, Gv, IP3 ) % 3. orders intermodulation distrotion
    out = 2/3*Gv/IP3*Vin.^3
end
