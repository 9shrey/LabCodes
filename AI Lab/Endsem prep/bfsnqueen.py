def valid(state, new_queen):
    for col, row in enumerate(state):
        if abs(row - new_queen) == abs(col - len(state)) or new_queen in state:
            return False
    return True

size = 8
queue = [(queen_pos,) for queen_pos in range(size)]
while queue:
    board_state = queue.pop(0)
    if len(board_state) == size:
        print('solution:', board_state)
        continue
    for queen_pos in range(size):
        if not valid(board_state, queen_pos):
            continue
        next_state = board_state + (queen_pos,)
        queue.append(next_state)