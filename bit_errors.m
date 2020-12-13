function num_of_bit_errors = bit_errors(est_b_seq,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% num_of_bit_errors=bit_errors(est_bit_seq,b)                                                        
% OUTPUT                                                                           
%     num_of_bit_errors: number of different bits between transmitted and decided bits                                                
%                                                                               
% INPUT                                                                             
%      est_bit_seq,b:bits to be compared
%                                                                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_of_bit_errors=0;
for count=1:length(b)
    if b(count)~=est_b_seq(count)
        num_of_bit_errors=num_of_bit_errors+1;
    end
end