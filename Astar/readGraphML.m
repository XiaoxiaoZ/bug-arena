function [nodes, edges, weights, X, Y] = readGraphML(filename)
    % Read GraphML file as XML
    xmlDoc = xmlread(filename);

    % Get all nodes and edges
    nodeList = xmlDoc.getElementsByTagName('node');
    edgeList = xmlDoc.getElementsByTagName('edge');

    numNodes = nodeList.getLength;
    numEdges = edgeList.getLength;

    % Initialize storage
    nodes = strings(numNodes, 1);
    X = zeros(numNodes, 1);
    Y = zeros(numNodes, 1);
    edges = zeros(numEdges, 2);
    weights = zeros(numEdges, 1);  % Initialize with zeros

    % Extract node information (IDs and coordinates)
    for i = 0:numNodes-1
        node = nodeList.item(i);
        nodeId = char(node.getAttribute('id'));
        nodes(i+1) = nodeId;

        % Find child elements containing coordinate data
        dataList = node.getElementsByTagName('data');
        for j = 0:dataList.getLength-1
            dataNode = dataList.item(j);
            keyAttr = char(dataNode.getAttribute('key'));

            % Assuming 'd4' is X and 'd5' is Y
            if strcmp(keyAttr, 'd4')
                X(i+1) = str2double(dataNode.getTextContent);
            elseif strcmp(keyAttr, 'd5')
                Y(i+1) = str2double(dataNode.getTextContent);
            end
        end
    end

    % Extract edge information (source, target, and weight)
    for i = 0:numEdges-1
        edge = edgeList.item(i);
        sourceId = char(edge.getAttribute('source'));
        targetId = char(edge.getAttribute('target'));

        % Convert node IDs to indices
        sourceIdx = find(nodes == sourceId);
        targetIdx = find(nodes == targetId);

        if isempty(sourceIdx) || isempty(targetIdx)
            warning('Invalid edge: %s → %s', sourceId, targetId);
            continue;
        end

        edges(i+1, :) = [sourceIdx, targetIdx];

        % Extract edge weight (use d15 for length)
        weightFound = false;
        dataList = edge.getElementsByTagName('data');
        for j = 0:dataList.getLength-1
            dataNode = dataList.item(j);
            keyAttr = char(dataNode.getAttribute('key'));

            % 'd15' represents edge length, which should be the weight
            if strcmp(keyAttr, 'd15')
                weights(i+1) = str2double(dataNode.getTextContent);
                weightFound = true;
            end
        end

        % If no weight found, compute Euclidean distance
        if ~weightFound
            x1 = X(sourceIdx);
            y1 = Y(sourceIdx);
            x2 = X(targetIdx);
            y2 = Y(targetIdx);
            weights(i+1) = sqrt((x2 - x1)^2 + (y2 - y1)^2);
        end
    end
end
