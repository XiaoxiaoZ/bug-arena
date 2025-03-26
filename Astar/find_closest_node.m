function closestNode = find_closest_node(G, coord)
    distances = vecnorm([G.X - coord(1,1), G.Y - coord(1,2)], 2, 2);
    [~, closestNode] = min(distances);
end