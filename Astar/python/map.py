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
# Compute shortest path using A* algorithm

# You can change the declearation, it is just an example
### YOUR code here
#route = a_star(xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)

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
