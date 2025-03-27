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