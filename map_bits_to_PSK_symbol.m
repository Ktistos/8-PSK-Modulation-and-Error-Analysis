function Xm =map_bits_to_PSK_symbol(b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Xm = map_bits_to_PSK_symbol(b)                                                          
% OUTPUT                                                                           
%     Xm: PSK symbol Xm=[cos(2*pi*m/8),sin(2*pi*m/8)]T                                                
%                                                                               
% INPUT                                                                             
%      b:bits to be translated to a symbol
%                                                                               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%the process bellow maps the b bit sequence to the gray code linked to a
%PSK symbol
map=b;

map(2)= xor(b(1),b(2));

map(3)=xor(b(2),b(3));

m=bi2de(map,'left-msb');
%the retrieved PSK symbol 
Xm=[cos(2*pi*m/8);sin(2*pi*m/8)];

end