def aStarAlgo(start_node, stop_node_list):
         
        open_set = set(start_node) 
        closed_set = set()
        g = {} 
        parents = {}
 
        g[start_node] = 0
        parents[start_node] = start_node
         
         
        while len(open_set) > 0:
            n = None
 
            for v in open_set:
                if n == None or g[v] + heuristic(v) < g[n] + heuristic(n):
                    n = v
             
                     
            if n in stop_node_list or Graph_nodes[n] == None:
                pass
            else:
                for (m, weight) in get_neighbors(n):
                    if m not in open_set and m not in closed_set:
                        open_set.add(m)
                        parents[m] = n
                        g[m] = g[n] + weight
                         
     
                    else:
                        if g[m] > g[n] + weight:
                            g[m] = g[n] + weight
                            parents[m] = n
                            if m in closed_set:
                                closed_set.remove(m)
                                open_set.add(m)
 
            if n == None:
                print('Path does not exist!')
                return None
            if n in stop_node_list:
                path = []
 
                while parents[n] != n:
                    path.append(n)
                    n = parents[n]
 
                path.append(start_node)
 
                path.reverse()
 
                print('Path found: {}'.format(path))
                return path
 
 
            open_set.remove(n)
            closed_set.add(n)
 
        print('Path does not exist!')
        return None
         
def get_neighbors(v):
    if v in Graph_nodes:
        return Graph_nodes[v]
    else:
        return None
def heuristic(n):
        H_dist = {
            'A': 7,
            'B': 3,
            'C': 4,
            'D': 6,
            'E': 5,
            'F': 6,
            'G1': 0,
            'G2': 0,
            'G3': 0,
            'S': 5            
        }
 
        return H_dist[n]
 
Graph_nodes = {
	'A':[('B',3),('G1',9)],
    'B':[('C',1),('A',2)],
    'C':[('G2',5),('F',7)],
    'D':[('C',2),('E',2)],
    'E':[('G3',7)],
    'F':[('G3',8),('D',2)],
    'G1':[None],
    'G2':[None],
    'G3':[None],
    'S':[('A',5),('D',6)],
}

aStarAlgo('S', ['G1','G2','G3'])