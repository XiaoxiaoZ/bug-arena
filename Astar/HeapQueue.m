classdef HeapQueue < handle
    properties
        Elements % Struct array with fields: priority, node, path (stored in cell array)
    end
    
    methods
        function obj = HeapQueue()
            obj.Elements = struct('priority', {}, 'node', {}, 'path', {});
        end
        
        function push(obj, node, priority, path)
            % Insert new element into heap
            newElement.priority = priority;
            newElement.node = node;
            newElement.path = {path}; % Store path as a cell array
            
            obj.Elements(end + 1) = newElement;
            obj.bubbleUp(length(obj.Elements));
        end
        
        function [priority, node, path] = pop(obj)
            % Extract minimum priority element
            if isempty(obj.Elements)
                error('HeapQueue is empty');
            end
            priority = obj.Elements(1).priority;
            node = obj.Elements(1).node;
            path = obj.Elements(1).path{1}; % Extract path correctly
            
            % Move last element to root and heapify
            obj.Elements(1) = obj.Elements(end);
            obj.Elements(end) = [];
            obj.bubbleDown(1);
        end
        
        function isEmpty = isEmpty(obj)
            isEmpty = isempty(obj.Elements);
        end
        
        function bubbleUp(obj, index)
            parentIndex = floor(index / 2);
            while index > 1 && obj.Elements(index).priority < obj.Elements(parentIndex).priority
                obj.Elements([index, parentIndex]) = obj.Elements([parentIndex, index]);
                index = parentIndex;
                parentIndex = floor(index / 2);
            end
        end
        
        function bubbleDown(obj, index)
            n = length(obj.Elements);
            while true
                left = 2 * index;
                right = left + 1;
                smallest = index;
                
                if left <= n && obj.Elements(left).priority < obj.Elements(smallest).priority
                    smallest = left;
                end
                if right <= n && obj.Elements(right).priority < obj.Elements(smallest).priority
                    smallest = right;
                end
                if smallest == index
                    break;
                end
                obj.Elements([index, smallest]) = obj.Elements([smallest, index]);
                index = smallest;
            end
        end
    end
end
