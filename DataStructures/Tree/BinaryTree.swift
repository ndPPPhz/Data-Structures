//
//  BT.swift
//  DataStructures
//
//  Created by Annino De Petra on 04/03/2021.
//

import Foundation

class BinaryTree<T>: Tree {
    var root: BTNode<T>?
    
    init(_ data: T? = nil) {
        guard let data = data else {
            return
        }
        self.root = BTNode(data)
    }

    // MARK: - Utility
    func search(_ data: T) -> Bool {
        // TODO
        return false
    }
    
    func insert(_ data: T) {
        // TODO
    }
    
    func delete(_ data: T) -> Bool {
        // TODO
        return false
    }
    
    private func recursiveHeight(node: BTNode<T>) -> Int {
        var leftHeight = -1
        var rightHeight = -1
        
        // Split the problem in two smaller ones.
        // Retrieve the height of the left and right subtree
        if let leftBTNode = node.left {
            leftHeight = recursiveHeight(node: leftBTNode)
        }
        
        if let rightBTNode = node.right {
            rightHeight = recursiveHeight(node: rightBTNode)
        }
        // When it reaches a leaf node, the height of the latter must be 0
        // hence the initial condition of setting left and right height to -1.
        // Max because the heighest of both the subtrees, is the height we want to return.
        return Swift.max(leftHeight, rightHeight) + 1
    }
    
    var height: Int {
        guard let rootBTNode = root else {
            return 0
        }
        return recursiveHeight(node: rootBTNode)
    }
    
    // MARK: - Depth First Traversal
    private func inorderTraversal(node: BTNode<T>, closure: (BTNode<T>) -> Void) {
        // If there is a left node
        if let leftBTNode = node.left {
            inorderTraversal(node: leftBTNode, closure: closure)
        }
        // Once all the left value node have been reached, evaluate the closure
        closure(node)
        
        // Now scan all the right nodes
        if let rightBTNode = node.right {
            inorderTraversal(node: rightBTNode, closure: closure)
        }
    }
    
    private func preorderTraversal(node: BTNode<T>, closure: (BTNode<T>) -> Void) {
        // Evaluate the closure first
        closure(node)
        
        // Go as deep as you can on the left side
        if let leftBTNode = node.left {
            preorderTraversal(node: leftBTNode, closure: closure)
        }
        
        // Go as deep as you can on the right side
        if let rightBTNode = node.right {
            preorderTraversal(node: rightBTNode, closure: closure)
        }
    }
    
    private func postorderTraversal(node: BTNode<T>, closure: (BTNode<T>) -> Void) {
        // Go as deep as you can on the left side
        if let leftBTNode = node.left {
            postorderTraversal(node: leftBTNode, closure: closure)
        }
        
        // Go as deep as you can on the right side
        if let rightBTNode = node.right {
            postorderTraversal(node: rightBTNode, closure: closure)
        }
        
        // Evaluate the closure at the end
        closure(node)
    }
    
    private func breadthTraversal(node: BTNode<T>, closure: (BTNode<T>) -> Void) {
        // FIFO
        let queue = Queue<BTNode<T>>()
        queue.add(node)
        
        while let node = queue.deque() {
            closure(node)
            if let leftNode = node.left {
                queue.add(leftNode)
            }
            
            if let rightNode = node.right {
                queue.add(rightNode)
            }
        }
    }
    
    func traversal(_ type: Traversal, closure: (BTNode<T>) -> Void) {
        if let root = root {
            switch type {
            case .inorder:
                inorderTraversal(node: root, closure: closure)
            case .postorder:
                postorderTraversal(node: root, closure: closure)
            case .preorder:
                preorderTraversal(node: root, closure: closure)
            case .breadth:
                breadthTraversal(node: root, closure: closure)
            }
        } else {
            print("Empty tree")
        }
    }
    
}

extension BinaryTree where T: Comparable {
    var isBinarySearchTree: Bool {
        /*
         If the inorder traversal of the tree returns items sorted already then the tree is also a binary search tree.
         I am looping through the items of a queue which holds the value of the traversed nodes to determine
        if the tree is also a BST. This can also be done without using such a structure and it will change from O(N) memory space to O(1)
        */
        let queue = Queue<T>()
        traversal(.inorder) {
            queue.add($0.data)
        }
        
        // An empty tree is a BST
        guard var tmpItem = queue.deque() else {
            return true
        }
        
        while let dequedItem = queue.deque() {
            guard tmpItem <= dequedItem else {
                return false
            }
            tmpItem = dequedItem
        }
        return true
    }
}
