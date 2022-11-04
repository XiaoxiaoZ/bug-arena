classdef ant
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID uint32
        path (:,1) edge
        currentBlock block
        map
        % ¨[edge Tau]
        pheromone
    end
    
    methods
        function obj = ant(ID, map, currentBlock)
            %UNTITLED3 Construct an instance of this class
            %   Detailed explanation goes here
            obj.ID = ID;
            obj.map = map;
            obj.currentBlock = currentBlock;
        end
        
        function path = addEdgeToPath(obj,edge)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.path = [obj.Path edge];
            path =obj.path;
        end
        
        function obj = goLeft(obj)
            leftBlock = obj.currentBlock.left();
            if ~(leftBlock.occupied || leftBlock.isBorder)
                obj.path(end+1) = edge(obj.currentBlock,leftBlock);
                obj.currentBlock = leftBlock;  
            end
        end
        function obj = goRight(obj)
            rightBlock = obj.currentBlock.right();
            if ~(rightBlock.occupied || rightBlock.isBorder)
                obj.path(end+1) = edge(obj.currentBlock,rightBlock);
                obj.currentBlock = rightBlock;                
            end
        end
        function obj = goUp(obj)
            upBlock = obj.currentBlock.up();
            if ~(upBlock.occupied || upBlock.isBorder)
                obj.path(end+1) = edge(obj.currentBlock,upBlock);
                obj.currentBlock = upBlock;                
            end
                end
        function obj = goDown(obj)
            downBlock = obj.currentBlock.down();
            if ~(downBlock.occupied || downBlock.isBorder)
                obj.path(end+1) = edge(obj.currentBlock,downBlock);
                obj.currentBlock = downBlock;                
            end
        end
        function [] = plotAnt(obj)
            imshow(obj.map')
            hold on
            scatter(obj.currentBlock.x,obj.currentBlock.y)
        end
    end
end

