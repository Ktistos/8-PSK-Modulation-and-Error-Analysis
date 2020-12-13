function num_of_symbol_errors =symbol_errors(est_X,X)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% num_of_symbol_errors =symbol_errors(est_X,X)                                                          
% OUTPUT                                                                           
%     num num_of_symbol_errors: number of falsely decided symbols                                               
%                                                                               
% INPUT                                                                             
%      est_X:estimated symbols
%      X:transmitted symbols
%                                                                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_of_symbol_errors=0;
for count=1:length(X(1,:))
    if X(1,count)~=est_X(1,count) || X(2,count)~=est_X(2,count) 
        num_of_symbol_errors=num_of_symbol_errors+1;
    end
end