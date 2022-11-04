classdef block
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x uint32
        y uint32
        isBorder logical
        occupied logical
        map 
    end
    
    methods
        function obj = block(x,y, map)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.x = x;
            obj.y = y;
            obj.map = map;
            obj.isBorder = obj.isOnBord();
            obj.occupied = obj.isOccupied();
        end
        function leftBlock = left(obj)
            leftBlock=block(obj.x-1,obj.y,obj.map);
        end
        function rightBlock = right(obj)
            rightBlock=block(obj.x+1,obj.y,obj.map);
        end
        function upBlock = up(obj)
            upBlock=block(obj.x,obj.y-1,obj.map);
        end
        function downBlock = down(obj)
            downBlock=block(obj.x,obj.y+1,obj.map);
        end
        function isBorder= isOnBord(obj)
            [m,n] = size(obj.map); 
            if(obj.x<1 || obj.x>m || obj.y<0 || obj.y>n)
                isBorder = true;
            else
                isBorder = false;
            end
        end
        function occu = isOccupied(obj)
            if(~obj.isBorder)
                if(~obj.map(obj.x,obj.y))
                    occu = true;
                else
                    occu = false;
                end
            else
                occu = true;
            end
        end
        function id = ID(obj)
            [~,n] = size(obj.map);
            id = obj.y + (obj.x-1)*n;
        end
    end
end

