classdef ant
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID uint32
        Path (:,1) edge
        CurrentBlock block
    end
    
    methods
        function obj = ant(ID)
            %UNTITLED3 Construct an instance of this class
            %   Detailed explanation goes here
            obj.ID = ID;
        end
        
        function Path = addEdgeToPath(obj,edge)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.Path = [obj.Path edge];
            Path =obj.path;
        end
    end
end

