function map = generateMap()
%GENERATEMAP Summary of this function goes here
%   Detailed explanation goes here
    map = mapClutter(100,{'Box','Plus','Circle'},'MapSize',[50 50],'MapResolution',5);
    map = occupancyMatrix(map);
end

