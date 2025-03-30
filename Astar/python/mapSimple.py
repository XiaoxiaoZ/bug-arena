import heapq
import math
import matplotlib.pyplot as plt
from typing import List, Dict, Tuple, Optional, Callable, TypeVar, Generic

T = TypeVar('T')  # Generic type for nodes

class Graph(Generic[T]):
    def __init__(self):
        self.nodes: Dict[T, Tuple[float, float]] = {}
        self.edges: Dict[T, List[Tuple[T, float]]] = {}
    
    def add_node(self, node: T, pos: Tuple[float, float]):
        self.nodes[node] = pos
        self.edges[node] = []
    
    def add_edge(self, node1: T, node2: T, weight: float):
        self.edges[node1].append((node2, weight))
        self.edges[node2].append((node1, weight))
    
    def neighbors(self, node: T) -> List[Tuple[T, float]]:
        return self.edges.get(node, [])

    def get_edge_data(self, node1: T, node2: T, default=None):
        for neighbor, weight in self.edges.get(node1, []):
            if neighbor == node2:
                return [{"length": weight}]
        return [default] if default is not None else []

# Create a more complex graph
graph = Graph[str]()
graph.add_node("A", (0, 0))
graph.add_node("B", (1, 2))
graph.add_node("C", (2, 4))
graph.add_node("D", (3, 2))
graph.add_node("E", (4, 0))
graph.add_node("F", (5, 3))
graph.add_node("G", (6, 1))
graph.add_node("H", (3, 5))

graph.add_edge("A", "B", 2.2)
graph.add_edge("B", "C", 2.2)
graph.add_edge("C", "D", 2.2)
graph.add_edge("D", "E", 2.2)
graph.add_edge("A", "D", 3.5)
graph.add_edge("B", "D", 2.0)
graph.add_edge("C", "H", 1.5)
graph.add_edge("H", "F", 2.5)
graph.add_edge("F", "G", 2.2)
graph.add_edge("E", "G", 2.8)
graph.add_edge("D", "F", 1.8)

# Find the shortest path from A to G
start_node = "A"
end_node = "G"
# YOUR code here
#route = a_star(xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)

print("Shortest path:", route)

# Visualization
# Todo
