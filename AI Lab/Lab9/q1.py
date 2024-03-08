def water_jug_problem(jug1_cap, jug2_cap, target_amount):
    j1 = 0
    j2 = 0
    actions = [("fill", 1), ("fill", 2), ("empty", 1), ("empty", 2), ("pour", 1, 2), ("pour", 2, 1)]

    visited = set()

    queue = [(j1, j2, [])]
    while queue:
        j1, j2, seq = queue.pop(0)

        if (j1, j2) not in visited:
            print("j1: ", j1, end=" ")
            print("j2: ", j2)
            visited.add((j1, j2))

            if j1 == target_amount:
                return seq

            for action in actions:
                if action[0] == "fill":
                    if action[1] == 1:
                        next_state = (jug1_cap, j2)
                    else:
                        next_state = (j1, jug2_cap)
                elif action[0] == "empty":
                    if action[1] == 1:
                        next_state = (0, j2)
                    else:
                        next_state = (j1, 0)
                else:
                    if action[1] == 1:
                        amount = min(j1, jug2_cap - j2)
                        next_state = (j1 - amount, j2 + amount)
                    else:
                        amount = min(j2, jug1_cap - j1)
                        next_state = (j1 + amount, j2 - amount)

                if next_state not in visited:
                    next_seq = seq + [action]
                    queue.append((next_state[0], next_state[1], next_seq))
    return None

result = water_jug_problem(4, 3, 2)
print(result)
