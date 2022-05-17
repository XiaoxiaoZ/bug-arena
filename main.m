clear
start1 = [1,250];
start2 = [570,250];
goal = [285,250];
path1 = [10,20;20,30;30,50];
path2 = [100,200;200,300;300,500];
time1 = 0;
time2 = 0;
initLoc1 = [-100,-100];
initLoc2 = [100,100];
done1 = false;
done2 = false;
map = generateMap();
map(183,500)
fmap = figure;
imshow(map')
hold on
scatter(start1(1,1),start1(1,2),'red')
scatter(start2(1,1),start2(1,2),'blue')
scatter(goal(1,1),goal(1,2))
pause;
for i = 1:10000000 
    tic;
    %[path1, tree1, done1] = algorithm1(map, path1, tree1, initLoc1, start1, goal)
    time1 = time1 + toc;
    tic;
    %algorithm 2
    %[path2, tree2, done2] = algorithm2(map, path1, tree2, initLoc2, start1, goal)
    time2 = time2 +toc;

    %plot path
    plot(path1(:,1),path1(:,2),'r')
    plot(path2(:,1),path2(:,2),'b')
    drawnow
    text1 = sprintf('Player 1 time: %f \n',time1);
    text2 = sprintf('Player 2 time: %f \n',time2);
    clc
    disp(text1);
    disp(text2);

    if(done1 || done2)
        break;
    end


end

