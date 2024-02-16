SuccList = asarray([[]])
Start='A'

Closed = list()
SUCCESS=True
FAILURE=False

def MOVEGEN(N):
    New_list=list()
    if N in SuccList.keys():
        New_list=SuccList[N]
    return New_list

def SORT(L):
    L.sort(key = lambda x: x[1])
    return L

def heu(Node): #Node = ['B',2]--> [Node[0],Node[1]]
    return Node[1]


def APPEND(L1,L2):
    New_list=list(L1)+list(L2)
    return New_list
def Hill_Climbing(Start):
    global Closed
    N=Start
    CHILD = MOVEGEN(N)
    SORT(CHILD)
    N=[Start,5]
    print("\nStart=",N)
    print("Sorted Child List=",CHILD)
    newNode=CHILD[0]
    CLOSED=[N]
    while (heu(newNode) < heu(N)) and (len(CHILD) !=0):
        print("\n--------------------------")
        N= newNode
        print("N=",N)
        CLOSED = APPEND(CLOSED,[N])
        CHILD = MOVEGEN(N[0])
        SORT(CHILD)
        print("Sorted Child List=",CHILD)
        print("CLOSED=",CLOSED)
        newNode=CHILD[0]
    Closed=CLOSED 

def main():
    a = int(input("Enter a number between -10 and 10: "))
    b = hill_climbing(a<=10,a)
    printf(b)


if __name__ =='__main__':
    main()