clear
start1 = [1,250];
start2 = [570,250];
goal = [285,250];
path1 = [10,20;20,30;30,50];
path2 = [100,200;200,300;300,500];
tree1 = [];
tree2 = [];
time1 = 0;
time2 = 0;
done1 = false;
done2 = false;
%map = generateMap();
map = generateEasyMap();
map(183,500)
fmap = figure;
imshow(map')
hold on
scatter(start1(1,1),start1(1,2),'red')
scatter(start2(1,1),start2(1,2),'blue')
scatter(goal(1,1),goal(1,2))
pause;
for i = 1:10000000 
    if done1 == false
        tic;
        [path1, tree1, done1] = algorithm1(map, path1, tree1, start1, goal)
        time1 = time1 + toc;
    else
        plot(path1(:,1),path1(:,2),'r')
    end
    if done2 == false
        tic;
        %algorithm 2
        %[path2, tree2, done2] = algorithm2(map, path1, tree2, start1, goal)
        time2 = time2 +toc;
    else
        %plot(path2(:,1),path2(:,2),'b')
    end
    %plot tree and path
    plotTree1(tree1);
    %plotTree2(tree2);

    
    drawnow
    text1 = sprintf('Player 1 time: %f \n',time1);
    text2 = sprintf('Player 2 time: %f \n',time2);
    clc
    disp(text1);
    disp(text2);

    if(done1 && done2)
        break;
    end


end

