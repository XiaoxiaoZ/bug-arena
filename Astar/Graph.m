classdef Graph
    % A generic graph class for A* algorithm
    properties
        G (:,:) double  % Graph adjacency matrix
        Nodes (:,1) double  % List of node IDs
    end
    
    methods
        function obj = Astar(G, Nodes)
            arguments
                G (:,:) double  % Ensure G is a 2D matrix
                Nodes (:,1) double  % Ensure Nodes is a column vector
            end
            obj.G = G;
            obj.Nodes = Nodes;
        end
        
        function neighbors = get_neighbors(obj, node)
            % Returns neighbors and their corresponding weights
            arguments
                obj Graph
                node (1,1) double {mustBeMember(node, obj.Nodes)}
            end
            neighbors = find(obj.G(node, :) > 0);  % Get connected nodes
        end
        
        function weight = get_edge_weight(obj, u, v)
            % Returns the weight of edge (u,v)
            arguments
                obj Graph
                u (1,1) double {mustBeMember(u, obj.Nodes)}
                v (1,1) double {mustBeMember(v, obj.Nodes)}
            end
            weight = obj.G(u, v);
        end
    end
end

