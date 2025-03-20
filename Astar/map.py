#lib to install
#pip install osmnx networkx
#pip install matplotlib

import math
import osmnx as ox
import networkx as nx
import heapq

print(ox.__version__)
ox.settings.log_console = True  # See logs for debugging
# Define the city or area you want to extract
G = ox.graph_from_place("Manhattan, New York, USA", network_type="drive")


# Remove unsupported attributes before saving
for u, v, data in G.edges(data=True):
    data.pop("geometry", None)  # Remove 'geometry' to avoid GraphML errors

# Save graph to GraphML
ox.save_graphml(G, "city_roads.graphml")
print("Graph saved successfully.")

# Plot the graph
#ox.plot_graph(G)

# Define start and end points (latitude, longitude)
start_point = (40.748817, -73.985428)  # Empire State Building
end_point = (40.730610, -73.935242)    # East Village

# Find nearest nodes
#pip install scikit-learn
start_node = ox.distance.nearest_nodes(G, X=start_point[1], Y=start_point[0])
end_node = ox.distance.nearest_nodes(G, X=end_point[1], Y=end_point[0])
def euclidean_distance(G, node1, node2):
    x1, y1 = G.nodes[node1]['x'], G.nodes[node1]['y']
    x2, y2 = G.nodes[node2]['x'], G.nodes[node2]['y']
    return math.sqrt((x1 - x2)**2 + (y1 - y2)**2)

def astar_search(G, start, goal):
    """A* algorithm to find the shortest path in a graph."""
    
    # Priority queue: stores (total_cost, node, path)
    open_set = []
    heapq.heappush(open_set, (0, start, []))
    
    # Cost dictionaries
    g_score = {node: float('inf') for node in G.nodes}  # Cost from start to node
    g_score[start] = 0
    
    f_score = {node: float('inf') for node in G.nodes}  # Estimated total cost
    f_score[start] = euclidean_distance(G, start, goal)
    
    # Set of visited nodes
    visited = set()
    
    while open_set:
        _, current, path = heapq.heappop(open_set)  # Get node with lowest f_score
        
        if current in visited:
            continue
        visited.add(current)
        
        path = path + [current]  # Update path
        
        # If goal is reached, return path
        if current == goal:
            return path
        
        # Explore neighbors
        for neighbor in G.neighbors(current):
            if neighbor in visited:
                continue
            
            # Get actual travel cost (edge weight)
            edge_data = G.get_edge_data(current, neighbor, default={})
            travel_cost = edge_data[0].get("length", 1)  # Default 1 if no length
            
            tentative_g_score = g_score[current] + travel_cost
            
            if tentative_g_score < g_score[neighbor]:
                g_score[neighbor] = tentative_g_score
                f_score[neighbor] = g_score[neighbor] + euclidean_distance(G, neighbor, goal)
                
                heapq.heappush(open_set, (f_score[neighbor], neighbor, path))
    
    return None  # No path found
# Compute shortest path using A* algorithm
#route = nx.astar_path(G, start_node, end_node, heuristic=lambda u, v: euclidean_distance(G, u, v), weight='length')
route = astar_search(G, start_node, end_node)

# Visualize the route
fig, ax = ox.plot_graph_route(
    G, route,
    route_linewidth=3,  # Make the route more visible
    route_color='red',   # Highlight the route in red
    node_size=0,         # Hide nodes for clarity
    edge_color='gray',   # Normal roads are gray
    bgcolor='white'      # White background for contrast
)
