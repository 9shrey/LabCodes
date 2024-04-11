import random

class World:
    def __init__(self):
        self.size = 4
        self.grid = [[None for _ in range(self.size)] for _ in range(self.size)]
        self.monkey = (0, 0)
        self.pit_prob = 0.2

    def initialize_grid(self):
        # Place banana
        self.banana = (random.randint(0, self.size-1), random.randint(0, self.size-1))
        x,y = self.banana
        self.grid[x][y] = 'B'
        # Place pits
        for i in range(self.size):
            for j in range(self.size):
                if (i, j) != self.monkey and (i, j) != self.banana:
                    if random.random() < self.pit_prob:
                        self.grid[i][j] = 'P'
        # Place agent
        self.monkey = (0, 0)
        self.grid[0][0] = 'M'

    def is_valid_move(self, position):
        x, y = position
        return 0 <= x < self.size and 0 <= y < self.size and self.grid[x][y] != 'P'

    def get_neighbors(self, position):
        x, y = position
        neighbors = [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)]
        return [neighbor for neighbor in neighbors if self.is_valid_move(neighbor)]

    def distance(self, pos1, pos2):
        x1, y1 = pos1
        x2, y2 = pos2
        return abs(x1 - x2) + abs(y1 - y2)

    def heuristic(self, position):
        # Heuristic function - Manhattan distance from monkey to banana
        return self.distance(position, self.banana)

    def hill_climb(self):
        current_position = self.monkey
        path = [current_position]
        while current_position != self.banana:
            neighbors = self.get_neighbors(current_position)
            if not neighbors:
                return -1  # No path found
            best_neighbor = min(neighbors, key=lambda x: self.heuristic(x))
            current_position = best_neighbor
            path.append(current_position)
        return "Found banana at", current_position, "Path:", path

# Test the implementation
w = World()
w.initialize_grid()
print("Monkey:", w.monkey)
print("Banana:", w.banana)
print("Grid:")
for row in w.grid:
    print(row)

print("Shortest path:", w.hill_climb())
