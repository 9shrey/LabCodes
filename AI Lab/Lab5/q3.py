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
	graph[1].append(2)
	graph[1].append(3)

	graph[2].append(4)

	graph[2].append(0)

	graph[4].append(5)
	graph[5].append(4)
	graph[6].append(5)
	graph[6].append(4)
	
	graph[6].append(1)
	
	graph[3].append(0)
	graph[3].append(6)


	#Maldon = 0
	#Tiptree = 1
	# Feering = 2
	#Clacton = 3
	# Blaxhall = 4
	# Dunwich = 5
	# Harwich = 6




	cost[(0, 1)] = 8
	cost[(1, 2)] = 3
	cost[(1, 3)] = 29

	cost[(2, 4)] = 46
	cost[(2, 0)] = 11

	cost[(4, 5)] = 15
	cost[(5, 4)] = 17

	cost[(6, 5)] = 53
	cost[(6, 4)] = 40
	cost[(6, 1)] = 31

	cost[(3, 0)] = 40
	cost[(3, 6)] = 17

	goal = []
	goal.append(5)
	
	answer = uniform_cost_search(goal, 0)
	answer.sort()

	print("Minimum cost is = ",answer[0])
