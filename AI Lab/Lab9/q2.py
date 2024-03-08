def DFS(a, b, target, path, visited, isSolvable):
    global jug1, jug2
    if a>jug1 or b>jug2 or a<0 or b<0:
        return
    if ((a, b) in visited):
        return
    
    path.append([a, b])
    visited[(a, b)]=1

    if(a==target or b==target):
        isSolvable=True

        if (a==target):
            if(b!=0):
                path.append([a, 0])
        if (b==target):
            if(a!=0):
                path.append([0, b])
    DFS(a, jug2, target, path, visited, isSolvable)
    DFS(jug1, b, target, path, visited, isSolvable)

    for i in range(max(jug1, jug2)+1):
        c=a+i
        d=b-i

        if(c==jug1 or (d==0 and d>=0)):
            DFS(c, d, target, path, visited, isSolvable)

        c=a-i
        d=b+i

        if((c==0 and c>=0) or d==jug2):
            DFS(c, d, target, path, visited, isSolvable)

    DFS(jug1, 0, target, path, visited, isSolvable)
    DFS(0, jug2, target, path, visited, isSolvable)

    if not isSolvable:
        return       


if __name__=="__main__":
    jug1, jug2, target = 4, 3, 2
    path=[]
    visited={}
    isSolvable=False
    DFS(0, 0, target, path, visited, isSolvable)
    for i in path:
        print(f"( {i[0]}, {i[1]} )")
