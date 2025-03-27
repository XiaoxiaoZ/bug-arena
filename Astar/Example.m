clc,clear
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
