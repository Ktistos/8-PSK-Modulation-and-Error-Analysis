clear all;

%Parameter declaration and initialization
T=0.001;
over=10;
Ts=T/over;
Fs=1/Ts;
A=4;
%roll of factor a
a=0.5;
Nf=4096;
N_bits=100;
F0=2000;
SNRdb=20;

%1.
%Creating a random bit sequence
b = (sign(randn(3*N_bits, 1)) + 1)/2;

%2.
%aquiring the PSK symbols corresponding to the PSK sequence
Xn = bits_to_8PSK(b);

%3.
%Creating the SRRC Pulse PHI
[phi,t]=srrc_pulse(T, over, A, a);

%aquiring Xin and XQn sequences
XIn=Xn(1,:);
XQn=Xn(2,:);

%creating delta pulse trains for those sequences
XIn_delta = 1/Ts * upsample(XIn, over);
XQn_delta = 1/Ts * upsample(XQn, over);

%time axis of the pulse trains
t_d=0:Ts:((N_bits)*T)-Ts;

%aquiring convolution of pulse trains with phi
[XI_n,t1]=conv_two_signals(XIn_delta,t_d,phi,t,Ts);  
[XQ_n,t2]=conv_two_signals(XQn_delta,t_d,phi,t,Ts);

%creating the periodograms for XI_n and XQ_n
PxQn_F=(abs(Ts*fftshift(fft(XQ_n,Nf))).^2)/(length(t1)*Ts);
PxIn_F=(abs(Ts*fftshift(fft(XI_n,Nf))).^2)/(length(t2)*Ts);

%axis of the periodograms
F_axis=Fs*[-0.5:1/Nf:0.5-1/Nf];

%plotting the above
figure;
subplot(2,1,1);
plot(t1,XI_n);
grid on;
xlabel('time in seconds')
title('X_I n');
subplot(2,1,2);
semilogy(F_axis,PxIn_F);
grid on;
xlabel('frequency in Hz');
title('periodogram of X_I n');

figure;
subplot(2,1,1);
plot(t2,XQ_n);
grid on;
xlabel('time in seconds')
title('X_Q n');
subplot(2,1,2);
semilogy(F_axis,PxQn_F);
grid on;
xlabel('frequency in Hz');
title('periodogram of X_Q n');

%4.
%multiplying XI_n and XQ_n with their corresponding carriers
XI_t=XI_n.*(2*cos(2*pi*F0*t1));
XQ_t=XQ_n.*((-2)*sin(2*pi*F0*t2));

%creating the periodograms for XI_t and XQ_t
PxI_F=(abs(Ts*fftshift(fft(XI_t,Nf))).^2)/(length(t1)*Ts);
%creating the periodograms for XI_n and XQ_n
PxQ_F=(abs(Ts*fftshift(fft(XQ_t,Nf))).^2)/(length(t2)*Ts);



%plotting the above
figure;
subplot(2,1,1);
plot(t1,XI_t);
grid on;
xlabel('time in seconds')
title('X_I (t)');
subplot(2,1,2);
semilogy(F_axis,PxI_F);
grid on;
xlabel('frequency in Hz');
title('periodogram of X_I (t)');

figure;
subplot(2,1,1);
plot(t2,XQ_t);
grid on;
xlabel('time in seconds')
title('X_Q (t)');
subplot(2,1,2);
semilogy(F_axis,PxQ_F);
grid on;
xlabel('frequency in Hz');
title('periodogram of X_Q (t)');

%5.


%construting the signal to be transimitted
X_t=XI_t+XQ_t;

%creating its periodogram 
Px_F=(abs(Ts*fftshift(fft(X_t,Nf))).^2)/(length(t1)*Ts);


%plotting the above
figure;
subplot(2,1,1);
plot(t1,X_t);
grid on;
xlabel('time in seconds')
title('X (t)');
subplot(2,1,2);
semilogy(F_axis,Px_F);
grid on;
xlabel('frequency in Hz');
title('periodogram of X (t)');

%7.

%variance of W(t)
varW=1/(Ts*(10^(SNRdb/10)));

%constructing W(t)
W_t=sqrt(varW)*randn(1,length(X_t));

%recieved signal Y(t)
Y_t=X_t + W_t ;

%8.
%multiplying with the corresponding carriers to demodulate
YI_t=Y_t.*(cos(2*pi*F0*t1));
YQ_t=Y_t.*(-sin(2*pi*F0*t1));

%creating their periodograms
PyI_F=(abs(Ts*fftshift(fft(YI_t,Nf))).^2)/(length(t1)*Ts);
PyQ_F=(abs(Ts*fftshift(fft(YQ_t,Nf))).^2)/(length(t1)*Ts);


%plotting the above
figure;
subplot(2,1,1);
plot(t1,YI_t);
grid on;
xlabel('time in seconds')
title('Y_I (t)');
subplot(2,1,2);
semilogy(F_axis,PyI_F);
grid on;
xlabel('frequency in Hz');
title('periodogram of Y_I (t)');

figure;
subplot(2,1,1);
plot(t2,YQ_t);
grid on;
xlabel('time in seconds')
title('Y_Q (t)');
subplot(2,1,2);
semilogy(F_axis,PyQ_F);
grid on;
xlabel('frequency in Hz');
title('periodogram of Y_Q (t)');

%9.
%making phi(-t)
phi=fliplr(phi);
t=-fliplr(t);

tmp=t1;
%aquiring convolution of the demodulated signals with phi
[YI_n,t1]=conv_two_signals(YI_t,tmp,phi,t,Ts);
[YQ_n,t2]=conv_two_signals(YQ_t,tmp,phi,t,Ts);


%creating their periodograms
PyIn_F=(abs(Ts*fftshift(fft(YI_n,Nf))).^2)/(length(t1)*Ts);
PyQn_F=(abs(Ts*fftshift(fft(YQ_n,Nf))).^2)/(length(t2)*Ts);

%plotting the above
figure;
subplot(2,1,1);
plot(t1,YI_n);
grid on;
xlabel('time in seconds')
title('Y_I n');
subplot(2,1,2);
semilogy(F_axis,PyIn_F);
grid on;
xlabel('frequency in Hz');
title('periodogram of Y_I n');

figure;
subplot(2,1,1);
plot(t2,YQ_n);
grid on;
xlabel('time in seconds')
title('Y_Q n');
subplot(2,1,2);
semilogy(F_axis,PyQn_F);
grid on;
xlabel('frequency in Hz');
title('periodogram of Y_Q n');

%10.
%sampling z(t) at kT for k=0...N-1, in order to retrieve the symbols
kT=[-t1(1)/Ts+1:over:((N_bits-1)*T - t1(1))/Ts+1];

YI_sample=YI_n(kT);
YQ_sample=YQ_n(kT);

%creating the sequence of the PSK symbols with noise
Y=[YI_sample;YQ_sample];
close all;
%plotting each symbol
scatterplot(Y');

%11.

[est_X, est_bit_seq] = detect_PSK_8(Y);

%12.
num_of_symbol_errors= symbol_errors(est_X,Xn);

%13.
num_of_bit_errors = bit_errors(est_bit_seq,b);
