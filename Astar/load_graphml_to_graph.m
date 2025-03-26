function G_obj = load_graphml_to_graph(filename)
    % Read GraphML file (nodes, edges, weights, coordinates)
    [nodes, edges, weights, X, Y] = readGraphML(filename);

    numNodes = length(nodes);
    adjMatrix = zeros(numNodes, numNodes);

    % Construct adjacency matrix
    for i = 1:size(edges, 1)
        source = edges(i, 1);
        target = edges(i, 2);
        weight = weights(i);

        adjMatrix(source, target) = weight;
        adjMatrix(target, source) = weight; % Assuming undirected graph
    end

    % Convert node IDs to numeric indices
    nodeIndices = (1:numNodes)';

    % Create Graph object
    G_obj = Graph(adjMatrix, nodeIndices, X, Y);
end
