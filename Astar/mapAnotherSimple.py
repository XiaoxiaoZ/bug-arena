import heapq
import math
import matplotlib.pyplot as plt
from typing import List, Dict, Tuple, Optional, Callable, TypeVar, Generic

T = TypeVar('T')  # Generic type for nodes

class Graph(Generic[T]):
    def __init__(self, node_list: List[T]):
        # Number of nodes
        self.n = len(node_list)
        
        # Mapping nodes to indices for the adjacency matrix
        self.node_index = {node: i for i, node in enumerate(node_list)}
        self.index_node = {i: node for i, node in enumerate(node_list)}
        
        # Adjacency matrix (using None to indicate no edge)
        self.adjacency_matrix = [[None] * self.n for _ in range(self.n)]
        
        # Positions of nodes (x, y)
        self.positions: Dict[T, Tuple[float, float]] = {}

    def add_node(self, node: T, pos: Tuple[float, float]):
        index = self.node_index[node]
        self.positions[node] = pos
    
    def add_edge(self, node1: T, node2: T, weight: float):
        index1 = self.node_index[node1]
        index2 = self.node_index[node2]
        self.adjacency_matrix[index1][index2] = weight
        self.adjacency_matrix[index2][index1] = weight  # Undirected graph by default
    
    def neighbors(self, node: T) -> List[Tuple[T, float]]:
        index = self.node_index[node]
        neighbors = []
        for i in range(self.n):
            if self.adjacency_matrix[index][i] is not None:
                neighbors.append((self.index_node[i], self.adjacency_matrix[index][i]))
        return neighbors

    def get_edge_data(self, node1: T, node2: T, default=None):
        index1 = self.node_index[node1]
        index2 = self.node_index[node2]
        weight = self.adjacency_matrix[index1][index2]
        if weight is not None:
            return [{"length": weight}]
        return [default] if default is not None else []

def euclidean_distance(graph: Graph[T], node1: T, node2: T) -> float:
    x1, y1 = graph.positions[node1]
    x2, y2 = graph.positions[node2]
    return math.sqrt((x1 - x2)**2 + (y1 - y2)**2)

def a_star(graph: Graph[T], start: T, goal: T, heuristic: Callable[[Graph[T], T, T], float]) -> Optional[List[T]]:
    """A* algorithm to find the shortest path in a graph."""
    open_set = []
    heapq.heappush(open_set, (heuristic(graph, start, goal), start, []))
    
    g_score: Dict[T, float] = {start: 0}
    visited = set()

    while open_set:
        _, current, path = heapq.heappop(open_set)
        
        if current in visited:
            continue
        visited.add(current)

        path = path + [current]
        
        if current == goal:
            return path
        
        for neighbor, _ in graph.neighbors(current):
            if neighbor in visited:
                continue
            edge_data = graph.get_edge_data(current, neighbor, default={})
            travel_cost = edge_data[0].get("length", 1)
            tentative_g_score = g_score[current] + travel_cost
            
            if tentative_g_score < g_score.get(neighbor, float('inf')):
                g_score[neighbor] = tentative_g_score
                f_score = tentative_g_score + heuristic(graph, neighbor, goal)
                heapq.heappush(open_set, (f_score, neighbor, path))
    
    return None

# Create a simple graph
node_list = ["A", "B", "C", "D", "E"]
graph = Graph[str](node_list)
graph.add_node("A", (0, 0))
graph.add_node("B", (1, 2))
graph.add_node("C", (2, 4))
graph.add_node("D", (3, 2))
graph.add_node("E", (4, 0))

graph.add_edge("A", "B", 2.2)
graph.add_edge("B", "C", 2.2)
graph.add_edge("C", "D", 2.2)
graph.add_edge("D", "E", 2.2)
graph.add_edge("A", "D", 3.5)
graph.add_edge("B", "D", 2.0)

# Find the shortest path from A to E
start_node = "A"
end_node = "E"
route = a_star(graph, start_node, end_node, lambda g, u, v: euclidean_distance(g, u, v))

print("Shortest path:", route)

# Visualization
plt.figure(figsize=(6,6))
for node, (x, y) in graph.positions.items():
    plt.scatter(x, y, color='blue')
    plt.text(x, y, node, fontsize=12, verticalalignment='bottom', horizontalalignment='right')
    
for node1 in graph.node_index:
    for node2, _ in graph.neighbors(node1):
        x1, y1 = graph.positions[node1]
        x2, y2 = graph.positions[node2]
        plt.plot([x1, x2], [y1, y2], 'gray', linestyle='--')

if route:
    path_x = [graph.positions[node][0] for node in route]
    path_y = [graph.positions[node][1] for node in route]
    plt.plot(path_x, path_y, 'r-', linewidth=2)

plt.title("Graph Visualization with A* Path")
plt.xlabel("X Coordinate")
plt.ylabel("Y Coordinate")
plt.grid(True)
plt.show()
