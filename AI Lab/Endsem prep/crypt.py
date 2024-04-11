use = [0]*10
class Node:
    def __init__(self,c,v =None):
        self.c = c
        self.v = v
def check(nodeArr, count, s1, s2, s3):
    val1, val2, val3 = 0,0,0
    m=1
    for i in range(len(s1)-1,-1,-1):
        ch = s1[i]
        for j in range(count):
            if ch == nodeArr[j].c:
                val1 += m*nodeArr[j].v
                break
        m*=10
    m=1
    for i in range(len(s2)-1,-1,-1):
        ch = s2[i]
        for j in range(count):
            if ch == nodeArr[j].c:
                val2 += m*nodeArr[j].v
                break
        m*=10
    m=1
    for i in range(len(s3)-1,-1,-1):
        ch = s3[i]
        for j in range(count):
            if ch == nodeArr[j].c:
                val3 += m*nodeArr[j].v
                break
        m*=10
    return 1 if val3==val2+val1 else 0
def permutation(count, nodeArr, n, s1, s2, s3):
    if n==count-1:
        for i in range(10):
            if use[i]==0:
                nodeArr[n].v = i
                if check(nodeArr, count, s1, s2, s3) == 1:
                    print("Solution: ")
                    for j in range(count):
                        print(f"{nodeArr[j].c} = {nodeArr[j].v}")
                    return True
        return False
    for i in range(10):
        if use[i]==0:
            nodeArr[n].v =i
            use[i]=1
            if permutation(count, nodeArr, n+1, s1, s2, s3):
                return True
            use[i]=0
    return False

def solveCryptographic(s1,s2,s3):
    count = 0
    l1,l2,l3 = len(s1),len(s2),len(s3)
    freq = [0]*26
    for i in range(l1):
        freq[ord(s1[i])-ord('A')]+=1
    for i in range(l2):
        freq[ord(s2[i])-ord('A')]+=1
    for i in range(l3):
        freq[ord(s3[i])-ord('A')]+=1
    for i in range(26):
        if freq[i]>0:
            count+=1
    if count>10:
        print("Invalid!")
        return False
    nodeArr = [Node(chr(i+ord('A'))) for i in range(26) if freq[i]>0]
    return permutation(count, nodeArr,0,s1,s2,s3)

s1 = "CROSS"
s2 = "ROADS"
s3 = "DANGER"

if not solveCryptographic(s1,s2,s3):
    print("No solution")
    