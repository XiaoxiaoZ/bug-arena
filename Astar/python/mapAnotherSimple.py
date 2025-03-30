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
# YOUR code here
#route = a_star(xxxxxxxxxxxxxxxxxxxxxxxxxxxxx)

print("Shortest path:", route)

# Visualization
#Todo
