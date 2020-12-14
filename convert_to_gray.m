function gray =convert_to_gray(b,invert)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gray =convert_to_gray(b)                                                          
% OUTPUT                                                                           
%     gray: converted gray code output                                               
%                                                                               
% INPUT                                                                             
%      b:bits to be converted to gray code
%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gray(1)=b(1);
gray(2)= xor(b(1),b(2));
if invert==0
    gray(3)=((~b(3)) &&xor(b(1),b(2))) || (b(3)&&(((~b(1))&&(~b(2))) || (b(1)&&b(2))));
elseif invert==1
    gray(3)= xor(b(2),b(3));
end

end