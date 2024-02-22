n = 3

rows = [1, 0, -1, 0]
cols = [0, -1, 0, 1]

class PriorityQueue:
    def __init__(self):
        self.queue = []

    def push(self, key):
        self.queue.append(key)

    def pop(self):
        min_index = 0
        for i in range(1, len(self.queue)):
            if self.queue[i].costs < self.queue[min_index].costs:
                min_index = i
        return self.queue.pop(min_index)

    def empty(self):
        return not bool(self.queue)

class Node:
    def __init__(self, parent, mats, empty_tile_posi, costs, levels):
        self.parent = parent
        self.mats = mats
        self.empty_tile_posi = empty_tile_posi
        self.costs = costs
        self.levels = levels

    def __lt__(self, nxt):
        return self.costs < nxt.costs

def calculateCosts(mats, final) -> int:
    count = 0
    for i in range(n):
        for j in range(n):
            if ((mats[i][j]) and (mats[i][j] != final[i][j])):
                count += 1
    return count

def newNodes(mats, empty_tile_posi, new_empty_tile_posi, levels, parent, final):
    new_mats = [row[:] for row in mats]
    x1, y1 = empty_tile_posi
    x2, y2 = new_empty_tile_posi
    new_mats[x1][y1], new_mats[x2][y2] = new_mats[x2][y2], new_mats[x1][y1]
    costs = calculateCosts(new_mats, final)
    new_node = Node(parent, new_mats, new_empty_tile_posi, costs, levels)
    return new_node

def printMatrix(mats):
    for row in mats:
        for elem in row:
            print("%d " % elem, end=" ")
        print()

def isSafe(x, y):
    return 0 <= x < n and 0 <= y < n

def printPath(root):
    if root is None:
        return
    printPath(root.parent)
    printMatrix(root.mats)
    print()

def solve(initial, empty_tile_posi, final):
    pq = PriorityQueue()
    costs = calculateCosts(initial, final)
    root = Node(None, initial, empty_tile_posi, costs, 0)
    pq.push(root)
    while not pq.empty():
        minimum = pq.pop()
        if minimum.costs == 0:
            printPath(minimum)
            return
        for i in range(n):
            new_tile_posi = [
                minimum.empty_tile_posi[0] + rows[i],
                minimum.empty_tile_posi[1] + cols[i], ]
            if isSafe(new_tile_posi[0], new_tile_posi[1]):
                child = newNodes(minimum.mats, minimum.empty_tile_posi, new_tile_posi, minimum.levels + 1, minimum, final)
                pq.push(child)

# Main Code

initial = [[1, 2, 3],
           [5, 6, 0],
           [7, 8, 4]]

final = [[1, 2, 3],
         [0, 8, 6],
         [5, 7, 4]]

empty_tile_posi = [1, 2]

solve(initial, empty_tile_posi, final)
