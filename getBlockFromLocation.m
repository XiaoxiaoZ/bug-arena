function b = getBlockFromLocation(x,y,map)
%GETBLOCKFROMLOCATION Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(map);
id = y + (x-1)*n;
if(~map(x,y))
    occu = true;
else
    occu = false;
end
b=block(id,x,y,occu);
end

