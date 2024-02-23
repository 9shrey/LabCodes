def f(x):
    if -10 <= x <= 10:
        return x
    else:
        return -1

def generate_neighbors(x):
    neighbors = []
    for i in [-1, 1]:
        neighbor = x + i
        if -10 <= neighbor <= 10:
            neighbors.append(neighbor)
    return neighbors

def hill_climbing(f, x0):
    x = x0  # initial solution
    best_solution = x0
    while True:
        neighbors = generate_neighbors(x)  # generate neighbors of x
        if not neighbors:  # if there are no neighbors, stop
            break
        # find the neighbor with the highest function value
        best_neighbor = max(neighbors, key=f)
        if f(best_neighbor) > f(best_solution):  # if the best neighbor is better than the current best solution, update the best solution
            best_solution = best_neighbor
        else:  # if the best neighbor is not better than the current best solution, stop
            break
        print(best_neighbor)
        x = best_neighbor  # continue with the best neighbor
    return best_solution

def main():
    a = int(input("Enter a number between -10 and 10: "))
    b = hill_climbing(f, a)
    print(b)

if __name__ == '__main__':
    main()