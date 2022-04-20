clear
path1 = [];
path2 = [];
time1 = 0;
time2 = 0;
initLoc1 = [-100,-100];
initLoc2 = [100,100];
done1 = false;
done2 = false;
map = generateMap();
for i = 1:10000000 
    tic;
    %[path1, tree1, done1] = algorithm1(map, path1, tree1, initLoc1)
    pause(2)
    time1 = time1 + toc
    tic;
    %algorithm 2
    %[path2, tree2, done2] = algorithm2(map, path1, tree2, initLoc2)
    pause(3)
    time2 = time2 +toc

    if(done1 || done2)
        break;
    end
end