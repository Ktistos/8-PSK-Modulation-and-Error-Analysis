function [conv_signal,conv_t] =conv_two_signals(signal1,t1,signal2,t2,step)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [conv_signal,conv_t] =conv_two_signals(signal1,t1,signal2,t2)                                                          
% OUTPUT                                                                           
%     conv_signal: result of convolution of signal1 and signal2
%     conv_t: time axis of conv_signal
%                                                                               
% INPUT                                                                             
%      signal1,signal2 : signals to be convoluted
%      t1,t2: time axis of the signals
%      step : step of the time axis
%                                                                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

conv_t=t1(1)+t2(1):step:t1(end) + t2(end);

conv_signal=step*conv(signal1,signal2);

end