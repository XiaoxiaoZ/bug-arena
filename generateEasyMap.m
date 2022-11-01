function map = generateEasyMap()
%GENERATEMAP Summary of this function goes here
%   Detailed explanation goes here
    map1 = mapMaze(5,1,'MapSize',[50 30],'MapResolution',1);
    map1 = occupancyMatrix(map1);
    map2 = flip(map1);
    map = ~[zeros(5,50);map1(6:15,:);zeros(5,50);map2(6:15,:);zeros(5,50)];
end

