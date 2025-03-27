classdef Graph
    % A generic graph class for A* algorithm with coordinates
    properties
        G (:,:) double  % Graph adjacency matrix
        Nodes (:,1) double  % List of node IDs
        X (:,1) double  % X-coordinates of nodes
        Y (:,1) double  % Y-coordinates of nodes
    end
    
    methods
        function obj = Graph(G, Nodes, X, Y)
            arguments
                G (:,:) double  % Ensure G is a 2D matrix
                Nodes (:,1) double  % Ensure Nodes is a column vector
                X (:,1) double  % X-coordinates
                Y (:,1) double  % Y-coordinates
            end
            obj.G = G;
            obj.Nodes = Nodes;
            obj.X = X;
            obj.Y = Y;
        end
        
        function neighbors = get_neighbors(G, node)
            % Find indices of all nonzero edges (connected nodes)
            neighbors = find(G.G(node, :) > 0);  % Assuming G.AdjMatrix stores edges
            
            if isempty(neighbors)
                warning('⚠️ Warning: Node %d has no neighbors!', node);
            end
        end
        
        function weight = get_edge_weight(obj, u, v)
            % Returns the weight of edge (u,v)
            weight = obj.G(u, v);
            if weight == 0
                fprintf('⚠️ Warning: No edge between %d and %d!\n', u, v);
            end
        end
        function plot_graph(obj, shortestPath)
            figure;
            hold on;
            axis equal;
            
            % Plot all edges from adjacency matrix
            [row, col] = find(obj.G > 0); % Get connected node pairs
            for i = 1:length(row)
                x = [obj.Y(row(i)), obj.Y(col(i))];
                y = [obj.X(row(i)), obj.X(col(i))];
                plot(x, y, 'k-', 'LineWidth', 1); % Black edges
            end
            
            % Plot nodes
            scatter(obj.Y, obj.X, 50, '.b', 'filled'); % Blue nodes
            
            % Plot shortest path if available
            if ~isempty(shortestPath)
                for i = 1:length(shortestPath) - 1
                    src = shortestPath(i);   % Extract numerical indices
                    tgt = shortestPath(i+1);
                    
                    x = [obj.Y(src), obj.Y(tgt)];
                    y = [obj.X(src), obj.X(tgt)];
                    
                    plot(x, y, 'r-', 'LineWidth', 2); % Red for shortest path
                end
            end
            
            hold off;
            xlabel('Longitude');
            ylabel('Latitude');
            title('Graph Visualization with Shortest Path');
            legend({'Edges', 'Nodes', 'Shortest Path'}, 'Location', 'best');
        end


    end
end
