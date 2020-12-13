function Yn = sampling(Yt,over,N,offset)
Yn=zeros(N,1);
for i=1:N
     Yn(i,1)=Yt(offset+1+(i-1)*over); 
end

return;