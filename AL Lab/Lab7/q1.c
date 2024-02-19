#include <stdio.h>
#include <stdlib.h>

struct Node {
  int key;
  struct Node *left;
  struct Node *right;
  int height;
};

int max(int a, int b) {
  return (a > b) ? a : b;
}

int height(struct Node *N) {
  if (N == NULL)
    return 0;
  return N->height;
}

struct Node *newNode(int key) {
  struct Node *node = (struct Node *)
    malloc(sizeof(struct Node));
  node->key = key;
  node->left = NULL;
  node->right = NULL;
  node->height = 1;
  return (node);
}

struct Node *rightRotate(struct Node *y) {
  struct Node *x = y->left;
  struct Node *T2 = x->right;

  x->right = y;
  y->left = T2;

  y->height = max(height(y->left), height(y->right)) + 1;
  x->height = max(height(x->left), height(x->right)) + 1;

  return x;
}

struct Node *leftRotate(struct Node *x) {
  struct Node *y = x->right;
  struct Node *T2 = y->left;

  y->left = x;
  x->right = T2;

  x->height = max(height(x->left), height(x->right)) + 1;
  y->height = max(height(y->left), height(y->right)) + 1;

  return y;
}

int getBalance(struct Node *N) {
  if (N == NULL)
    return 0;
  return height(N->left) - height(N->right);
}

struct Node *insertNode(struct Node *node, int key) {
  if (node == NULL)
    return (newNode(key));

  if (key < node->key)
    node->left = insertNode(node->left, key);
  else if (key > node->key)
    node->right = insertNode(node->right, key);
  else
    return node;
  node->height = 1 + max(height(node->left),
               height(node->right));

  int balance = getBalance(node);
  if (balance > 1 && key < node->left->key)
    return rightRotate(node);

  if (balance < -1 && key > node->right->key)
    return leftRotate(node);

  if (balance > 1 && key > node->left->key) {
    node->left = leftRotate(node->left);
    return rightRotate(node);
  }

  if (balance < -1 && key < node->right->key) {
    node->right = rightRotate(node->right);
    return leftRotate(node);
  }

  return node;
}

void findPreSuc(struct Node* root, struct Node** pre, struct Node** suc, int key)
{
    if (root == NULL)  return ;
    if (root->key == key)
    {        
        if (root->left != NULL)
        {
            struct Node* tmp = root->left;
            while (tmp->right)
                tmp = tmp->right;
            *pre = tmp;
        }
        if (root->right != NULL)
        {
            struct Node* tmp = root->right;
            while (tmp->left)
                tmp = tmp->left;
            *suc = tmp;
        }
        return ;
    } 
    if (root->key > key)
    {
        *suc = root ;
        findPreSuc(root->left, pre, suc, key) ;
    }
    else 
    {
        *pre = root ;
        findPreSuc(root->right, pre, suc, key) ;
    }
}

void printPreOrder(struct Node *root) {
  if (root != NULL) {
    printf("%d ", root->key);
    printPreOrder(root->left);
    printPreOrder(root->right);
  }
}

int main() {
	struct Node *root = NULL;
    int key;

	root = insertNode(root, 2);
	root = insertNode(root, 1);
	root = insertNode(root, 7);
	root = insertNode(root, 4);
	root = insertNode(root, 5);
	
	printPreOrder(root);

	struct Node* pre = NULL, *suc = NULL;
    printf("\nEnter key whose pre and suc to find: ");
    scanf("%d",&key);

    findPreSuc(root, &pre, &suc, key);
    if (pre != NULL)
        printf("\nPredecessor is %d\n", pre->key);
    else
        printf("\nNo Predecessor");

    if (suc != NULL)
        printf("\nSuccessor is %d\n", suc->key);
    else
        printf("\nNo Successor");
    return 0;
}


//OUTPUT

// 21547
// Enter key to be searched: 3

// Predecessor is 2

// Successor is 4
