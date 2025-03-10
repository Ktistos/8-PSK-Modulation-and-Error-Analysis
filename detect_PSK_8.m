function [est_X,est_bit_sequence] =detect_PSK_8(Y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [est_X,est_bit_sequence] =detect_PSK_8(Y)                                                          
% OUTPUT                                                                           
%     est_X: estimated symbol sequence
%     est_bit_sequence: estimated bit sequence
%                                                                               
% INPUT                                                                             
%      Y : sequence of the PSK symbols with noise
%                                                                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%initializing est_X for performance
est_X=zeros(2,length(Y(1,:)));

est_bit_sequence=[];
test=[];
%loop through all the aquired PSK symbols with noise
for count=1:length(Y(1,:))

    max_dot_product=-1;
    decided_m=-1;
    %Checking to find the maximum dot product of the aquired symbol with the
    %theoretical ones.We decide that the aquired PSK symbol corresponds to
    %the theoretical which had the maximum dot product with the aquired symbol. 
    for m=1:8
        %computing theoretical symbol
        xm=[cos(2*pi*(m-1)/8) sin(2*pi*(m-1)/8)];
        %computing dot product of the theoretical with the aquired symbols
        temp=xm * Y(:,count);
        %choosing the max dot product of them all
        if temp>max_dot_product
            max_dot_product=temp;
            decided_m=m-1;
        end
    end
    %storing the decided symbol to the return matrix
    est_X(1,count)=cos(2*pi*(decided_m)/8);
    est_X(2,count)=sin(2*pi*(decided_m)/8);
    %aquiring the bit sequence which corresponds to the decided xm
    char_bits=dec2bin(decided_m,3);
    bits=[str2num(char_bits(1)) str2num(char_bits(2)) str2num(char_bits(3))];
    bits=convert_to_gray(bits,1);
    est_bit_sequence=[est_bit_sequence bits];
end
