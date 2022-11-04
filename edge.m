classdef edge
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        From
        To
        Tau
    end
    
    methods
        function obj = edge(From, To)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.From = From;
            obj.To = To;
        end
    end
end

