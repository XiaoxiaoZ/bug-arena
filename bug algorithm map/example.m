map = createMap(3);
imshow(map')

initPoint = [1,1];
goalPoint = size(map);

line=moveTowords([1,1],goalPoint);
line(findContact(line,map),:)


hold on 
plot(line(:,1),line(:,2))

function map = createMap(numOfObj)
%Generate a map in size pixel 150x250 with number of objects given
%   generate map
map = mapClutter(numOfObj,{'Box'},'MapSize',[50 30],'MapResolution',5);
%   convert it to binary matrix
map = occupancyMatrix(map);
end

function line = moveTowords(now,goal)
%Line between now and goal will return according, smaller x first and xs
%can not be the same
diff=goal-now;
k = diff(2)/diff(1);
line = [];
for i=now(1):goal(1)
    line=[line;i,round(now(2)+(i-now(1))*k)]
end
end

function contactIndex = findContact(line,map)
%Find the point index on line contact the first contact object
[n,~] = size(line);
for i=1:n
    if(map(line(i,1),line(i,2)))
        contactIndex=i;
        return
    end
end
end



