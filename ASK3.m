clear all;

%Parameter declaration and initialization
T=0.001;
over=10;
Ts=T/over;
Fs=1/Ts;
A=4;
%roll of factor a
a=0.5;
Nf=2048;
N_bits=100;

%1.
%Creating a random bit sequence
b = (sign(randn(3*N_bits, 1)) + 1)/2;

%2.
%aquiring the PSK symbols corresponding to the PSK sequence
symbols = bits_to_8PSK(b);

