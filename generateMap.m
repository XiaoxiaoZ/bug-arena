function map = generateMap()
%GENERATEMAP Summary of this function goes here
%   Detailed explanation goes here
    map1 = mapMaze(10,10,'MapSize',[500 300],'MapResolution',1);
    map1 = occupancyMatrix(map1);
    map2 = flip(map1);
    map = ~[zeros(10,500);map1(16:285,:);zeros(10,500);map2(16:285,:);zeros(10,500)];
end

