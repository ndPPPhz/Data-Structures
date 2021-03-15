//
//  Trie.swift
//  DataStructures
//
//  Created by Annino De Petra on 15/03/2021.
//

import Foundation

final class Trie<T: Hashable, U:Collection> where U.Element == T {
    final class Node {
        private var children: [T: Node] =  [:]
        fileprivate(set) var isFinal = false
        fileprivate(set) var count: Int = 0
        
        init() {}
        
        subscript(_ element: T) -> Node? {
            get {
                return children[element]
            }
            
            set {
                children[element] = newValue
            }
        }
    }
    
    // MARK: - Properties
    private let root = Node()
    
    // MARK: - Init
    init() {}
    
    // MARK: - Helper
    private func getNode(for collection: U) -> Node? {
        var currentNode = root
        
        // Starting from root, check if each node contains the element as child
        for element in collection {
            if let node = currentNode[element] {
                currentNode = node
            } else {
                return nil
            }
        }
        return currentNode
    }
    
    // MARK: - Insert
    func insert(_ collection: U) {
        // Check if the sequence already exists
        guard !find(collection) else {
            return
        }
        
        var currentNode = root
        
        // Starting from root, if the current node already has a child whose value is the current element
        // set it as new current node. Otherwise, create the node and set it as new current node.
        // When the loop traverses each node, since it's a new word, increase the count
        for element in collection {
            currentNode.count += 1
            
            if let node = currentNode[element] {
                currentNode = node
            } else {
                let newNode = Node()
                currentNode[element] = newNode
                currentNode = newNode
            }
        }
        // When it reaches the end, set the last node as final
        currentNode.isFinal = true
    }
    
    // MARK: - Find
    func find(_ collection: U) -> Bool {
        guard let node = getNode(for: collection) else {
            return false
        }
        
        return node.isFinal
    }
    
    // MARK: - Word count
    func count(for collection: U) -> Int {
        guard let node = getNode(for: collection) else {
            return 0
        }
        
        // If it's a leaf node, its count is 0 but it could be the final node of a sequence
        let isFinal = node.isFinal
        let totalCount = node.count + (isFinal ? 1 : 0)
        return totalCount
    }
}
