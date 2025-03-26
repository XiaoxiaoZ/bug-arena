function shortestPath = astar(G, startNode, goalNode, euclidean_distance)
    % Initialize heap-based priority queue
    openSet = HeapQueue();
    openSet.push(startNode, euclidean_distance(G, startNode, goalNode), {startNode});
    
    % Cost tracking
    gScore = containers.Map('KeyType', 'double', 'ValueType', 'double');
    gScore(startNode) = 0;
    
    visited = containers.Map('KeyType', 'double', 'ValueType', 'logical');

    while ~openSet.isEmpty()
        % Get node with lowest fScore
        [~, current, path] = openSet.pop();

        % If already visited, continue
        if isKey(visited, current) && visited(current)
            continue;
        end
        visited(current) = true;
        
        path = [path, {current}];
        % Check if goal is reached
        if current == goalNode
            shortestPath = cell2mat(path);
            return;
        end

        % Explore neighbors
        neighbors = G.get_neighbors(current);
        for i = 1:length(neighbors)
            neighbor = neighbors(i);
            
            % Skip visited nodes
            if isKey(visited, neighbor) && visited(neighbor)
                continue;
            end
            
            % Get actual travel cost (edge weight, default to 1 if missing)
            travelCost = G.get_edge_weight(current, neighbor);
            if travelCost == 0
                travelCost = 1; % Default weight if missing
            end
            % Calculate tentative gScore
            tentativeGScore = gScore(current) + travelCost;
            
            if ~isKey(gScore, neighbor) || (tentativeGScore < gScore(neighbor))
                gScore(neighbor) = tentativeGScore;
                fScore = tentativeGScore + euclidean_distance(G, neighbor, goalNode);
                openSet.push(neighbor, fScore, path);
            end
        end
    end

    shortestPath = []; % No path found
end