//
//  BST.swift
//  DataStructures
//
//  Created by Annino De Petra on 04/03/2021.
//

import Foundation

class BinarySearchTree<T: Comparable>: BinaryTree<T> {    
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
    
    override func search(_ data: T) -> Bool {
        if let root = root {
            return recursiveSearch(data, node: root)
        } else {
            return false
        }
    }
    
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
    
    // MARK: - Utility
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
    
    override func insert(_ data: T) {
        if let root = root {
            // If root exist start a recursive search of the leaf
            recursiveInsert(data, node: root)
        } else {
            // If there is no root
            root = BTNode(data)
        }
    }
}
