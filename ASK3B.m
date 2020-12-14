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
N_bits=300;
num_of_symbols=N_bits/3;
F0=2000;
K=200;

SNRdb=[-2:2:16];
exp_prob=zeros(2,10);
upper_bound_prob=zeros(1,10);
for index=1:length(SNRdb)
    num_of_symbol_errors=0;
    num_of_bit_errors=0;
    for count=1:K
        %Creating a random bit sequence
        b = (sign(randn(N_bits, 1)) + 1)/2;

        %aquiring the PSK symbols corresponding to the PSK sequence
        Xn = bits_to_8PSK(b);

        %Creating the SRRC Pulse PHI
        [phi,t]=srrc_pulse(T, over, A, a);

        %aquiring Xin and XQn sequences
        XIn=Xn(1,:);
        XQn=Xn(2,:);

        %creating delta pulse trains for those sequences
        XIn_delta = 1/Ts * upsample(XIn, over);
        XQn_delta = 1/Ts * upsample(XQn, over);

        %time axis of the pulse trains
        t_d=0:Ts:((num_of_symbols)*T)-Ts;

        %aquiring convolution of pulse trains with phi
        [XI_n,t1]=conv_two_signals(XIn_delta,t_d,phi,t,Ts);  
        [XQ_n,t2]=conv_two_signals(XQn_delta,t_d,phi,t,Ts);

        %multiplying XI_n and XQ_n with their corresponding carriers
        XI_t=XI_n.*(2*cos(2*pi*F0*t1));
        XQ_t=XQ_n.*((-2)*sin(2*pi*F0*t2));

        %construting the signal to be transimitted
        X_t=XI_t+XQ_t;

        %variance of W(t)
        varW=1/(Ts*(10^(SNRdb(index)/10)));

        %constructing W(t)
        W_t=sqrt(varW)*randn(1,length(X_t));

        %recieved signal Y(t)
        Y_t=X_t + W_t ;

        %multiplying with the corresponding carriers to demodulate
        YI_t=Y_t.*(cos(2*pi*F0*t1));
        YQ_t=Y_t.*(-sin(2*pi*F0*t1));

        %making phi(-t)
        phi=fliplr(phi);
        t=-fliplr(t);

        tmp=t1;
        %aquiring convolution of the demodulated signals with phi
        [YI_n,t1]=conv_two_signals(YI_t,tmp,phi,t,Ts);
        [YQ_n,t2]=conv_two_signals(YQ_t,tmp,phi,t,Ts);

        %sampling z(t) at kT for k=0...N-1, in order to retrieve the symbols
        kT=[-t1(1)/Ts+1:over:((num_of_symbols-1)*T - t1(1))/Ts+1];

        YI_sample=YI_n(kT);
        YQ_sample=YQ_n(kT);

        %creating the sequence of the PSK symbols with noise
        Y=[YI_sample;YQ_sample];

        %11.
        [est_X, est_bit_seq] = detect_PSK_8(Y);

        %12.
        num_of_symbol_errors=num_of_symbol_errors +  symbol_errors(est_X,Xn);

        %13.
        num_of_bit_errors = num_of_bit_errors+bit_errors(est_bit_seq,b);
    end
    SNR=10^(SNRdb(index)/10);
    upper_bound_prob(index)=2*Q(sqrt(2*SNR)*sin(pi/8));
    exp_prob(1,index)=num_of_symbol_errors/(K*num_of_symbols);
    exp_prob(2,index)=num_of_bit_errors/(K*N_bits);
end

figure;
semilogy(SNRdb,exp_prob(1,:));
hold on;
semilogy(SNRdb,upper_bound_prob);
grid on;
xlim([-2 17]);
figure;
semilogy(SNRdb,exp_prob(2,:));
hold on;
semilogy(SNRdb,upper_bound_prob/3);
grid on;
xlim([-2 17]);


