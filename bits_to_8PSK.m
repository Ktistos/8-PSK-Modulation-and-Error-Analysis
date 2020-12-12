function symbols = bits_to_8PSK(b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% symbols= bits_to_8PSK(b)                                                           
% OUTPUT                                                                           
%      symbol: 8PSK symbol sequence. 2x(length(b)/3) matrix.                                              
%                                                                               
% INPUT                                                                             
%      b: bit sequence to be modulated
%                                                                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=transpose(b);

%initializing the variables for efficiency
tmp_bits=zeros(1,3);
symbols=zeros(2,length(b)/3);
index=1;
%loop through all the bit triads of the sequence to convert each one to a
%symbol
for count=1:3:length(b)
        
    tmp_bits(1)=b(count);
    tmp_bits(2)=b(count+1);
    tmp_bits(3)=b(count+2);
    %converting the bit triad to the corresponding PSK symbol an storing
    %it in the symbols matrix.
    symbols(:,index)=map_bits_to_PSK_symbol(tmp_bits);
    index=index +1 ;
end


end