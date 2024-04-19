#include <stdio.h>
#include <stdlib.h>

// Structure for a binary tree node
struct TreeNode {
    int data;
    struct TreeNode *left;
    struct TreeNode *right;
};

// Function to create a new binary tree node
struct TreeNode* newNode(int data) {
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->data = data;
    node->left = node->right = NULL;
    return node;
}

// Function to find index of value 'val' in array 'arr'
int findIndex(int arr[], int val, int start, int end) {
    for (int i = start; i <= end; ++i) {
        if (arr[i] == val)
            return i;
    }
    return -1; // Not found
}

// Function to construct a binary search tree from in-order and post-order traversals
struct TreeNode* buildTree(int in[], int post[], int inStart, int inEnd, int* postIndex) {
    if (inStart > inEnd)
        return NULL;

    // Pick current node from postorder traversal using postIndex and decrement it
    struct TreeNode* node = newNode(post[(*postIndex)--]);

    // If this node has no children, return it
    if (inStart == inEnd)
        return node;

    // Find index of this node in in-order traversal
    int inIndex = findIndex(in, node->data, inStart, inEnd);

    // Construct right subtree
    node->right = buildTree(in, post, inIndex + 1, inEnd, postIndex);
    // Construct left subtree
    node->left = buildTree(in, post, inStart, inIndex - 1, postIndex);

    return node;
}

// Function to traverse the binary tree in breadth-first-search (DFS) order
void breadthFirstSearch(struct TreeNode* root) {
    if (root == NULL)
        return;

    // Queue to store nodes for BFS traversal
    struct TreeNode* queue[1000];
    int front = 0, rear = 0;

    queue[rear++] = root;

    while (front < rear) {
        struct TreeNode* current = queue[front++];
        printf("%d ", current->data);

        if (current->left != NULL)
            queue[rear++] = current->left;
        if (current->right != NULL)
            queue[rear++] = current->right;
    }
}

// Function to construct the binary search tree from in-order and post-order traversals
struct TreeNode* bst_construct(int in[], int post[], int size) {
    int postIndex = size - 1; // Start from the last element of post-order traversal
    return buildTree(in, post, 0, size - 1, &postIndex);
}

// Main function
int main() {
    int inOrder[] = {5, 10, 15, 20, 25, 30, 45};
    int postOrder[] = {5, 15, 10, 25, 45, 30, 20};
    int size = sizeof(inOrder) / sizeof(inOrder[0]);

    // Construct the binary search tree
    struct TreeNode* root = bst_construct(inOrder, postOrder, size);

    // Traverse and print the binary search tree in breadth-first-search order
    printf("Breadth-first-search traversal of the constructed BST:\n");
    breadthFirstSearch(root);
    printf("\n");

    return 0;
}
