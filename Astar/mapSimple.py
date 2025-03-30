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

def euclidean_distance(graph: Graph[T], node1: T, node2: T) -> float:
    x1, y1 = graph.nodes[node1]
    x2, y2 = graph.nodes[node2]
    return math.sqrt((x1 - x2)**2 + (y1 - y2)**2)

def a_star(graph: Graph[T], start: T, goal: T, heuristic: Callable[[T, T], float]) -> Optional[List[T]]:
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
        
        for neighbor, travel_cost in graph.neighbors(current):
            if neighbor in visited:
                continue
            tentative_g_score = g_score[current] + travel_cost
            
            if tentative_g_score < g_score.get(neighbor, float('inf')):
                g_score[neighbor] = tentative_g_score
                f_score = tentative_g_score + heuristic(graph, neighbor, goal)
                heapq.heappush(open_set, (f_score, neighbor, path))
    
    return None

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
route = a_star(graph, start_node, end_node, lambda g, u, v: euclidean_distance(g, u, v))

print("Shortest path:", route)

print("Shortest path:", route)

# Visualization
plt.figure(figsize=(6,6))
for node, (x, y) in graph.nodes.items():
    plt.scatter(x, y, color='blue')
    plt.text(x, y, node, fontsize=12, verticalalignment='bottom', horizontalalignment='right')
    
for node1 in graph.edges:
    for node2, _ in graph.edges[node1]:
        x1, y1 = graph.nodes[node1]
        x2, y2 = graph.nodes[node2]
        plt.plot([x1, x2], [y1, y2], 'gray')

if route:
    path_x = [graph.nodes[node][0] for node in route]
    path_y = [graph.nodes[node][1] for node in route]
    plt.plot(path_x, path_y, 'r-', linewidth=2)

plt.title("Graph Visualization with A* Path")
plt.xlabel("X Coordinate")
plt.ylabel("Y Coordinate")
plt.grid(True)
plt.show()
