#include <stdio.h>
#include<stdlib.h>

int opcount = 0;

typedef struct node {
	int data;
	struct node* left;
	struct node* right;
}node;

int totalNodes(node* root)
{
	opcount++;
	if (root == NULL)
		return 0;

	int l = totalNodes(root->left);
	int r = totalNodes(root->right);

	return 1 + l + r;
}

struct node* newNode(int data)
{
	struct node* Node = (struct node*)malloc(sizeof(struct node));
	Node->data = data;
	Node->left = NULL;
	Node->right = NULL;
	return (Node);
}

int main()
{
	struct node* root = newNode(1);
	root->left = newNode(2);
	root->right = newNode(3);

	root->left->left = newNode(4);
	root->left->right = newNode(5);

	// root->right->left = newNode(9);
	// root->right->right = newNode(8);

	// root->left->left->left = newNode(6);
	// root->left->left->right = newNode(7);

	// root->left->right->left = newNode(76);
	// root->left->right->right = newNode(74);

	// root->left->left->right->left = newNode(11);
	// root->left->left->right->right = newNode(17);
	
	// root->left->left->left->left = newNode(131);
	// root->left->left->left->right = newNode(173);

	int sum = totalNodes(root);
	printf("Total node count is %d\n",sum);
	printf("Opcount is %d\n", opcount);
	return 0;
}


//OUTPUT
//Total node count is 5
// Opcount is 11
