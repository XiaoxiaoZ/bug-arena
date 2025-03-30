clc,clear
%% Part1
% Define the graph parameters
Nodes = [1, 2, 3, 4, 5];  % Node IDs
X = [0, 1, 2, 3, 4];  % X-coordinates of the nodes
Y = [0, 2, 4, 2, 0];  % Y-coordinates of the nodes

% Define the adjacency matrix (edge weights between nodes)
% 0 indicates no edge between the nodes
G = [
    0, 2.2, 0, 3.5, 0;  % Node 1 connected to Node 2 with weight 2.2, Node 4 with weight 3.5
    2.2, 0, 2.2, 2.0, 0;  % Node 2 connected to Node 1 with weight 2.2, Node 3 with weight 2.2, Node 4 with weight 2.0
    0, 2.2, 0, 2.2, 0;    % Node 3 connected to Node 2 with weight 2.2, Node 4 with weight 2.2
    3.5, 2.0, 2.2, 0, 2.2;  % Node 4 connected to Node 1 with weight 3.5, Node 2 with weight 2.0, Node 3 with weight 2.2, Node 5 with weight 2.2
    0, 0, 0, 2.2, 0     % Node 5 connected to Node 4 with weight 2.2
];

% Create the graph object
simpleGraph = Graph(G, Nodes, X, Y);
startCoord = [0,0];  % Start location in (x, y)
goalCoord = [4,0];   % Goal location in (x, y)
% Find the closest nodes to the input coordinates
startNode = find_closest_node(simpleGraph,startCoord);
goalNode = find_closest_node(simpleGraph,goalCoord);
shortestPath = astar(simpleGraph, startNode, goalNode,@euclidean_distance);

% Display results
disp("Shortest Path:");
disp(shortestPath);
% Plot the graph
simpleGraph.plot_graph(shortestPath);

%% Part 2
% Load GraphML data into your custom Graph class
G_obj= load_graphml_to_graph("Manhattan_city_roads.graphml");
%%
% Pick start and goal nodes
startCoord = [40.8457, -73.9369];  % Start location in (x, y)
goalCoord = [40.730610, -73.99];   % Goal location in (x, y)
% Find the closest nodes to the input coordinates
startNode = find_closest_node(G_obj,startCoord);
goalNode = find_closest_node(G_obj,goalCoord);
shortestPath = astar(G_obj, startNode, goalNode,@euclidean_distance);

% Display results
disp("Shortest Path:");
disp(shortestPath);
%%
% Plot the graph
G_obj.plot_graph(shortestPath);

hold off
