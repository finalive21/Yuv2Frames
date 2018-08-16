A=imresize(frames(1).frame,[512 512]);
qA=qtdecomp(A,0.20,[8 64]);
blocks = repmat(uint8(0),size(qA));

for dim = [64 32 16 8];    
  numblocks = length(find(qA==dim));    
  if (numblocks > 0)
    values = repmat(uint8(1),[dim dim numblocks]);
    values(2:dim,2:dim,:) = 0;
    blocks = qtsetblk(blocks,qA,dim,values);
  end
end

blocks(end,1:end) = 1;
blocks(1:end,end) = 1;

figure,imshow(blocks,[]);