% Create adjacency matrix for a small graph
G_matrix = [
    0 1 4 0;
    1 0 2 5;
    4 2 0 1;
    0 5 1 0
];

% Define nodes
nodes = [1; 2; 3; 4];

% Create graph
G = Graph(G_matrix, nodes);

% Set start and goal
start_node = 1;
goal_node = 4;

% Run A* algorithm
path = a_star(G, start_node, goal_node, @euclidean_distance);

% Display result
disp("Shortest Path: "), disp(path);

function dist = euclidean_distance(G, node1, node2)
    % Compute Euclidean distance between two nodes
    arguments
        G Graph
        node1 (1,1) double
        node2 (1,1) double
    end
    [x1, y1] = ind2sub(size(G.G), node1);
    [x2, y2] = ind2sub(size(G.G), node2);
    dist = sqrt((x1 - x2)^2 + (y1 - y2)^2);
end

function path = a_star(G, start, goal, heuristic)
    % A* Algorithm for shortest path search
    arguments
        G Graph
        start (1,1) double {mustBeMember(start, G.Nodes)}
        goal (1,1) double {mustBeMember(goal, G.Nodes)}
        heuristic function_handle
    end
    
    % Priority queue (f_score, node, path)
    open_set = [heuristic(G, start, goal), start, []];  
    g_score = containers.Map('KeyType', 'double', 'ValueType', 'double');
    g_score(start) = 0;
    
    visited = [];

    while ~isempty(open_set)
        % Extract node with lowest f-score
        [~, idx] = min(open_set(:, 1));
        current = open_set(idx, 2);
        path = open_set(idx, 3:end);
        open_set(idx, :) = []; % Remove processed node
        
        if ismember(current, visited)
            continue;
        end
        visited = [visited; current];

        path = [path, current];  % Extend path

        if current == goal
            return;
        end

        % Explore neighbors
        neighbors = G.get_neighbors(current);
        for i = 1:length(neighbors)
            neighbor = neighbors(i);
            if ismember(neighbor, visited)
                continue;
            end

            travel_cost = G.get_edge_weight(current, neighbor);
            tentative_g_score = g_score(current) + travel_cost;

            if ~isKey(g_score, neighbor) || tentative_g_score < g_score(neighbor)
                g_score(neighbor) = tentative_g_score;
                f_score = tentative_g_score + heuristic(G, neighbor, goal);
                open_set = [open_set; f_score, neighbor, path];  
            end
        end
    end
    path = [];  % No path found
end
