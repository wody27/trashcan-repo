class Node: 
    def __init__(self,item):
        self.item = item
        self.left = None
        self.right = None
class BinaryTree:
    def __init__(self):
        self.root = None
    def preorder(self, n):
        if n != None:
            print(n.item)
            self.preorder(n.left)
            self.preorder(n.right)
    def inorder(self, n):
        if n != None:
            self.inorder(n.left)
            print(n.item)
            self.inorder(n.right)
    def postorder(self, n):
        if n != None:
            self.postorder(n.left)
            self.postorder(n.right)
            print(n.item)

tree = BinaryTree()
n1 = Node(15)
n2 = Node(1)
n3 = Node(37)
n4 = Node(61)
n5 = Node(26)
n6 = Node(59)
n7 = Node(48)

tree.root = n1
n1.left=n2
n1.right=n3
n2.left=n4
n2.right=n5
n3.left=n6
n3.right=n7

print("Preorder Traverse")
tree.preorder(n1)
print("Inorder Traverse")
tree.inorder(n1)
print("Postorder Traverse")
tree.postorder(n1)