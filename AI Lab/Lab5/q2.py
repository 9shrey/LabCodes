def uniform_cost_search(goal, start):
	global graph,cost
	answer = []
	queue = []
	for i in range(len(goal)):
		answer.append(10**8)
	queue.append([0, start])
	visited = {}
	count = 0
	while (len(queue) > 0):
		queue = sorted(queue)
		p = queue[0]
		del queue[0]
		if (p[1] in goal):
			index = goal.index(p[1])
			if (answer[index] == 10**8):
				count += 1
			if (answer[index] > p[0]):
				answer[index] = p[0]

			queue = sorted(queue)
			if (count == len(goal)):
				return answer

		if (p[1] not in visited):
			for i in range(len(graph[p[1]])):

				queue.append( [p[0] + cost[(p[1], graph[p[1]][i])], graph[p[1]][i]] )

		visited[p[1]] = 1

	return answer






if __name__ == '__main__':
	
	graph,cost = [[] for i in range(10)],{}

	graph[0].append(1)
	graph[0].append(2)
	graph[0].append(4)
	
	graph[1].append(2)
	graph[1].append(7)
	
	graph[2].append(1)
	graph[2].append(3)

	graph[3].append(0)
	graph[3].append(6)
	graph[3].append(8)

	graph[4].append(3)
	graph[4].append(5)

	graph[5].append(9)

	graph[6].append(4)
	graph[6].append(9)



	cost[(0, 1)] = 5
	cost[(0, 2)] = 9
	cost[(0, 4)] = 6

	cost[(1, 2)] = 3
	cost[(1, 7)] = 9

	cost[(2, 1)] = 2
	cost[(2, 3)] = 1

	cost[(3, 0)] = 6
	cost[(3, 6)] = 7
	cost[(3, 8)] = 5

	cost[(4, 3)] = 2
	cost[(4, 5)] = 2

	cost[(5, 9)] = 7

	cost[(6, 4)] = 2
	cost[(6, 9)] = 8


	

	goal = []
	goal.append(7)
	goal.append(8)
	goal.append(9)
	
	answer = uniform_cost_search(goal, 0)
	answer.sort()

	print("Minimum cost is = ",answer[0])
