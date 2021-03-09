//
//  BST.swift
//  DataStructures
//
//  Created by Annino De Petra on 04/03/2021.
//

import Foundation

final class BinarySearchTree<T: Comparable>: BinaryTree<T> {
    // MARK: - Search
    private func recursiveSearch(_ data: T, node: BTNode<T>) -> Bool {
        if node.data == data {
            return true
        }
        
        if data <= node.data {
            if let leftNode = node.left {
                return recursiveSearch(data, node: leftNode)
            } else {
                return false
            }
        } else  {
            if let rightNode = node.right {
                return recursiveSearch(data, node: rightNode)
            } else {
                return false
            }
        }
    }
    
    
    /// Searches if data is present in the the binary search tree
    ///
    /// Time complexity: O (log_2(N)) if the tree is balanced. O(N) if not.
    /// - Returns: True if data is in the tree. False otherwise
    override func search(_ data: T) -> Bool {
        if let root = root {
            return recursiveSearch(data, node: root)
        } else {
            return false
        }
    }
    
    /// Searches the min value stored in the tree
    ///
    /// Time complexity: O (log_2(N)) if the tree is balanced. O(N) if not.
    /// - Returns: The value. Otherwise nil if the tree doesn't contain any value
    var min: T? {
        guard let rootNode = root else {
            return nil
        }
        // Iterative search of the min. Since it's a BST
        // the most left node is the min
        var currentMin = rootNode
        
        while let left = currentMin.left {
            currentMin = left
        }
        
        return currentMin.data
    }
    
    /// Searches the min value stored in the tree
    ///
    /// Time complexity: O (log_2(N)) if the tree is balanced. O(N) if not.
    /// - Returns: The value. Otherwise nil if the tree doesn't contain any value
    var max: T? {
        guard let rootNode = root else {
            return nil
        }
        // Iterative search of the Max. Since it's a BST
        // the most right node is the max
        var currentMax = rootNode
        
        while let right = currentMax.right {
            currentMax = right
        }
        
        return currentMax.data
    }
    
    // MARK: - Insert
    private func recursiveInsert(_ data: T, node: BTNode<T>) {
        // Based on the value of data, move to the proper subtree
        // data smaller that the node's data
        if data <= node.data {
            // If exist a left node recall recursively the same method
            if let leftNode = node.left {
                recursiveInsert(data, node: leftNode)
            } else {
                // Otherwise we have found where to append the node
                node.left = BTNode(data)
            }
        } else {
            // data bigger that the node's data
            if let rightNode = node.right {
                // If exist a right node recall recursively the same method
                recursiveInsert(data, node: rightNode)
            } else {
                // Otherwise we have found where to append the node
                node.right = BTNode(data)
            }
        }
    }
    
    /// Insert data in the tree
    ///
    /// Time complexity: O (log_2(N)) if the tree is balanced. O(N) if not.
    override func insert(_ data: T) {
        if let root = root {
            // If root exist start a recursive search of the leaf
            recursiveInsert(data, node: root)
        } else {
            // If there is no root
            root = BTNode(data)
        }
    }
    
    // MARK: - Delete
    private func findAndDetachMinNodeFromRightSubtree(node: BTNode<T>) -> T {
        guard var tmpMin = node.right else {
            fatalError("Attempting to call a function which needs the right subtree not to be nil with a nil right child")
        }
        
        var tmpParent = node
        
        while let leftNode = tmpMin.left {
            tmpParent = tmpMin
            tmpMin = leftNode
        }
        
        recursiveDelete(tmpMin.data, node: tmpMin, parent: tmpParent)
        return tmpMin.data
    }
    
    private func removeNodeFromTree(node: BTNode<T>, parent: BTNode<T>?) {
        let isLeafNode: (BTNode<T>) -> Bool = {
            return $0.left == nil && $0.right == nil
        }
        
        /*
        We need to determine the nature of the node we want to remove.
        It can fall into three separated categories:
        
         - Leaf node: Here we only need to unlink the node from its parent
         - It has 1 subtree: We need to link the parent with the root node of its subtree
         - It has 2 subtrees: We need to search for the min node of the right subtree or the max of the left one, detach it and set its value to the node we are going to remove
        */
        
        if isLeafNode(node) {
            if let parent = parent {
                if parent.left?.data == node.data {
                    parent.left = nil
                } else {
                    parent.right = nil
                }
            } else {
                // If it's a leaf node and it doesn't have neither left nor right child, it must be the root.
                root = nil
            }
        } else if node.left == nil {
            /*
            O <- Parent
             \
              O <- Node
               \
                O <- Node's right subtree
            */
            if let parent = parent {
                parent.left = node.right
            } else {
                // If it doesn't have a parent it must be the root
                root = node.right
            }
        } else if node.right == nil {
            /*
                     O <- Parent
                    /
                  O <- Node
                 /
                O <- Node's left subtree
            */
            if let parent = parent {
                parent.left = node.left
            } else {
                // If it doesn't have a parent it must be the root
                root = node.left
            }
        } else {
            let minRightSubtreeValue = findAndDetachMinNodeFromRightSubtree(node: node)
            node.data = minRightSubtreeValue
        }
    }
    
    @discardableResult
    private func recursiveDelete(_ data: T, node: BTNode<T>, parent: BTNode<T>?) -> Bool {
        // If data == current visited node, we found the node we want to remove
        if data == node.data {
            removeNodeFromTree(node: node, parent: parent)
            return true
        } else if
            // Otherwise let's proceed recursively with the usual binary search
            data <= node.data,
            let leftNode = node.left
        {
            return recursiveDelete(data, node: leftNode, parent: node)
        } else if
            data > node.data,
            let rightNode = node.right
        {
            return recursiveDelete(data, node: rightNode, parent: node)
        } else {
            // If it reaches this point, it means that the value we want to remove doesn't exist in the tree
            return false
        }
    }
    
    /// Removed data from within the tree
    ///
    /// Time complexity: O (log_2(N)) if the tree is balanced. O(N) if not.
    @discardableResult
    override func delete(_ data: T) -> Bool {
        // Check if it's an empty tree
        guard let root = root else {
            return false
        }
        // Let's search the node in the BST
        return recursiveDelete(data, node: root, parent: nil)
    }
}
