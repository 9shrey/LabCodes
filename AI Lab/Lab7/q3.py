initial = [[1,2,3],[5,6,0],[7,8,4]]
final = [[1,2,3],[5,8,6],[0,7,4]]
n=3
empty_tile = [1,2]

def calculateCosts(mats, final) -> int:  
      
    count = 0  
    for i in range(n):  
        for j in range(n):  
            if ((mats[i][j]) and  
                (mats[i][j] != final[i][j])):  
                count += 1  
                  
    return count

def solve(initial, empty_tile, final):
	costs = calculateCosts(initial, final)


def copy_matrix(mats):
    # Create a new matrix with the same dimensions
    new_mats = [[0] * n for _ in range(n)]

    # Copy the values from the original matrix to the new matrix
    for i in range(n):
        for j in range(n):
            new_mats[i][j] = mats[i][j]

    return new_mats

def newNodes(mats, empty_tile_posi, new_empty_tile_posi, levels, parent, final):
    # Copying data from the parent matrixes to the present matrixes
    new_mats = copy_matrix(mats)

    # Moving the tile by 1 position
    x1 = empty_tile_posi[0]
    y1 = empty_tile_posi[1]
    x2 = new_empty_tile_posi[0]
    y2 = new_empty_tile_posi[1]
    new_mats[x1][y1], new_mats[x2][y2] = new_mats[x2][y2], new_mats[x1][y1]

    # Setting the no. of misplaced tiles
    costs = calculateCosts(new_mats, final)

    new_nodes = nodes(parent, new_mats, new_empty_tile_posi, costs, levels)
    return new_nodes