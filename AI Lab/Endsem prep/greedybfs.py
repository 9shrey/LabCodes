def greedybfs(start,stop):
    open = set(start)
    close = set()
    g = {}
    parents = {}
    g[start] = 0
    parents[start] = start

    while(len(open)>0):
        n = None
        for v in open:
            if n==None or heuristic(v)<heuristic(n):
                n = v
        if n==stop or Graph_nodes[n]==None:
            pass
        else:
            for (m,weight) in get_neighbors(n):
                if m not in open and m not in close:
                    open.add(m)
                    parents[m] = n
                    g[m] = g[n]+weight
                else:
                    if(g[m]>g[n]+weight):
                        g[m] = g[n]+weight
                        parents[m] = n
                        if m in close:
                            close.remove(m)
                            open.add(m)
        if n==None:
            print("No path")
            return None
        if n==stop:
            path = []
            while parents[n]!=n:
                path.append(n)
                n = parents[n]
            path.append(start)
            path.reverse()
            print(f"Path: {path}")
            return path
        open.remove(n)
        close.add(n)
    print("no path")
    return None



def get_neighbors(v):
    if v in Graph_nodes:
        return Graph_nodes[v]
    else:
        return None
    
def heuristic(n):
        H_dist = {
            'A': 10,
            'B': 8,
            'C': 5,
            'D': 7,
            'E': 3,
            'F': 6,
            'G': 5,
            'H': 3,
            'I': 1,
            'J': 0            
        }
 
        return H_dist[n]
 
Graph_nodes = {
	'A':[('B',6),('F',3)],
    'B':[('C',3),('D',2)],
    'C':[('D',1),('E',5)],
    'D':[('E',8)],
    'E':[('I',5),('J',5)],
    'F':[('G',1),('H',7)],
    'G':[('I',3)],
    'H':[('I',2)],
    'I':[('E',5),('J',3)],
    'J':[('E',5),('I',3)],
}

greedybfs('A', 'J') 