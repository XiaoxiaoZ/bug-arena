function map = generateEasyMap()
%GENERATEMAP Summary of this function goes here
%   Detailed explanation goes here
    map1 = mapMaze(50,10,'MapSize',[500 300],'MapResolution',1);
    map1 = occupancyMatrix(map1);
    map2 = flip(map1);
    map = ~[zeros(50,500);map1(55:245,:);zeros(88,500);map2(55:245,:);zeros(50,500)];
end

