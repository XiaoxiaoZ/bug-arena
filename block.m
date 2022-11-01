classdef block
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ID uint32
        x uint32
        y uint32
        Occu logical
    end
    
    methods
        function obj = block(ID,x,y,Occu)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.ID = ID;
            obj.x = x;
            obj.y = y;
            obj.Occu = Occu;
        end
    end
end

