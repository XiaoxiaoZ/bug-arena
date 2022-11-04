classdef MazeSolver
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Ants (:,1) ant
        Map (:,1) block
        Edges (:,1) edge
    end
    
    methods
        function obj = MazeSolver(numberOfAnts, map)
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here
            disp("initing ants")
            for i=1:numberOfAnts
                obj.Ants(end+1) = ant(i,block(1,25));
            end
            [m,n] = size(map);   
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

