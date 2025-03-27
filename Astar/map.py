#lib to install
#pip install osmnx networkx
#pip install matplotlib

import math
import osmnx as ox
import networkx as nx
import heapq
from typing import TypeVar, Generic, Dict, List, Tuple, Optional, Callable

T = TypeVar('T')  # Generic type for nodes

class Graph(Generic[T]):
    """Generic Graph class with a method to get neighbors."""
    def neighbors(self, node: T) -> List[Tuple[T, int]]:
        raise NotImplementedError("Subclasses must implement this method")
    def get_edge_weight(self, u: T, v: T) -> float:
        """Should return the weight of the edge between u and v."""
        raise NotImplementedError("Subclasses must implement this method")

print(ox.__version__)
ox.settings.log_console = True  # See logs for debugging
# Define the city or area you want to extract
G = ox.graph_from_place("Manhattan, New York, USA", network_type="drive")
# # Define start and end points (latitude, longitude)
start_point = (40.8457, -73.9369)  # Empire State Building
end_point = (40.730610, -73.99)    # East Village
#G = ox.graph_from_place("Trollhättan, Sweden", network_type="drive")
#start_point = (58.3004, 12.1444)  # Empire State Building
#end_point = (58.1401, 12.4198)    # East Village

# Remove unsupported attributes before saving
for u, v, data in G.edges(data=True):
    data.pop("geometry", None)  # Remove 'geometry' to avoid GraphML errors

# Save graph to GraphML
ox.save_graphml(G, "Manhattan_city_roads.graphml")
print("Graph saved successfully.")

# Plot the graph
#ox.plot_graph(G)



# Find nearest nodes
#pip install scikit-learn
start_node = ox.distance.nearest_nodes(G, X=start_point[1], Y=start_point[0])
end_node = ox.distance.nearest_nodes(G, X=end_point[1], Y=end_point[0])
def euclidean_distance(G, node1, node2):
    x1, y1 = G.nodes[node1]['x'], G.nodes[node1]['y']
    x2, y2 = G.nodes[node2]['x'], G.nodes[node2]['y']
    return math.sqrt((x1 - x2)**2 + (y1 - y2)**2)
# Common way
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

def a_star(graph: Graph[T], start: T, goal: T, heuristic: Callable[[T, T], float]) -> Optional[List[T]]:
    """A* algorithm to find the shortest path in a graph."""
    
    # Priority queue (f_score, node, path)
    open_set = []
    heapq.heappush(open_set, (heuristic(start, goal), start, []))
    
    # Cost tracking
    g_score: Dict[T, float] = {start: 0}
    visited = set()

    while open_set:
        _, current, path = heapq.heappop(open_set)  # Node with lowest f_score
        
        if current in visited:
            continue
        visited.add(current)

        path = path + [current]  # Extend path
        
        if current == goal:
            return path  # Return shortest path
        
        for neighbor in graph.neighbors(current):
            if neighbor in visited:
                continue
            # Get actual travel cost (edge weight)
            edge_data = G.get_edge_data(current, neighbor, default={})
            travel_cost = edge_data[0].get("length", 1)  # Default 1 if no length
            
            tentative_g_score = g_score[current] + travel_cost
            
            if tentative_g_score < g_score.get(neighbor, float('inf')):
                g_score[neighbor] = tentative_g_score
                f_score = tentative_g_score + heuristic(neighbor, goal)
                
                heapq.heappush(open_set, (f_score, neighbor, path))
    
    return None  # No path found

# Compute shortest path using A* algorithm
#route = nx.astar_path(G, start_node, end_node, heuristic=lambda u, v: euclidean_distance(G, u, v), weight='length')
#route = astar_search(G, start_node, end_node)
route = a_star(G, start_node, end_node, heuristic=lambda u, v: euclidean_distance(G, u, v))
# Plot the route if found
if route:
    # Visualize the route
    fig, ax = ox.plot_graph_route(
        G, route,
        route_linewidth=3,  # Make the route more visible
        route_color='red',   # Highlight the route in red
        node_size=0,         # Hide nodes for clarity
        edge_color='gray',   # Normal roads are gray
        bgcolor='white'      # White background for contrast
    )
else:
    print("No path found.")
