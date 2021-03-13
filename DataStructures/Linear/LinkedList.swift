//
//  LinkedList.swift
//  DataStructures
//
//  Created by Annino De Petra on 13/03/2021.
//

import Foundation

class LinkedList<T: Equatable> {
    class Node: Equatable {
        static func == (lhs: LinkedList<T>.Node, rhs: LinkedList<T>.Node) -> Bool {
            return lhs.data == rhs.data && lhs.next === rhs.next
        }
        
        let data: T
        var next: Node?
        
        init(_ data: T, next: Node? = nil) {
            self.data = data
            self.next = next
        }
        
        // MARK: - NSCopying
        func copy(with zone: NSZone? = nil) -> Any {
            let newNode = Node(data)
            
            // Setting reference to the current and the next node
            var currentNode = newNode as Node?
            var nextNode = next
            
            // Iterate till it reaches the end
            while nextNode != nil {
                // Make a copy of the next node and set as next of the current copied node
                let nextNodeCopied = nextNode?.copy() as! Node
                currentNode?.next = nextNodeCopied
                // Iterate
                currentNode = nextNode
                nextNode = currentNode?.next
            }
            
            return newNode
        }
        
    }
    
    // MARK: - Properties
    private(set) var head: Node?
    private(set) var tail: Node?
    
    // MARK: - Init
    init() {}
    
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let newList = LinkedList()
        
        // Copy all nodes
        if
            let head = head,
            let copiedHead = head.copy() as? Node
        {
            newList.setNewHead(copiedHead)
        }
        
        return newList
    }
    
    // MARK: - Append
    func add(_ data: T) {
        let newNode = Node(data)
        
        if head == nil {
            head = newNode
            tail = head
        } else {
            tail?.next = newNode
            tail = newNode
        }
    }
    
    // MARK: - Traverse
    func traverse(closure: (Node) -> Void) {
        var tmpNode = head
        
        while let currentNode = tmpNode {
            closure(currentNode)
            tmpNode = currentNode.next
        }
    }
    
    private func recursiveReversedTraverse(node: Node, closure: (Node) -> Void) {
        if let nextNode = node.next {
            recursiveReversedTraverse(node: nextNode, closure: closure)
        }
        closure(node)
    }
    
    func reversedTraverse(closure: (Node) -> Void) {
        guard let head = head else {
            return
        }
        recursiveReversedTraverse(node: head, closure: closure)
    }
    
    // MARK: - Search
    @discardableResult
    func search(_ data: T) -> Bool {
        var tmpNode = head
        
        while let currentNode = tmpNode, currentNode.data != data {
            tmpNode = currentNode.next
        }
        
        if tmpNode != nil {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Remove
    @discardableResult
    func remove(_ data: T) -> Bool {
        guard let head = head else {
            return false
        }
        
        if head.data == data {
            if head.next == nil {
                self.head = nil
                self.tail = nil
            } else {
                self.head = head.next
            }
            return true
        } else {
            var beforeNode = head
            var node = head.next
            
            while let currentNode = node, currentNode.data != data {
                beforeNode = currentNode
                node = node?.next
            }
            
            if node != nil {
                beforeNode.next = node?.next
                return true
            } else {
                return false
            }
        }
    }
    
    // MARK: - Utilities
    func setNewHead(_ headNode: Node) {
        head = headNode
        tail = head
        
        var tailIterator = tail
        
        while let newTail = tailIterator?.next {
            tail = newTail
            tailIterator = newTail.next
        }
    }
    
    var hasCycles: Bool {
        guard
            head != nil,
            head?.next != nil
        else {
            return false
        }
        
        var oneNodeAtATimeIterator = head
        var twoNodesAtATimeIterator = head?.next
        
        while twoNodesAtATimeIterator != nil {
            if oneNodeAtATimeIterator == twoNodesAtATimeIterator {
                return true
            }
            oneNodeAtATimeIterator = oneNodeAtATimeIterator?.next
            twoNodesAtATimeIterator = twoNodesAtATimeIterator?.next?.next
        }
        return false
    }
    
    /// Reverses the linked list in place.
    func reverse() {
        guard
            head != nil,
            head?.next != nil
        else {
            return
        }
        
        
        /*
        We need to keep track of
         - previous node: it's going to be the new next
         - current node: the node we are changing the link to
         - new node: to store a reference to the unlinked next which is going to be the next current
        */
        var previous: Node? = nil
        var current = head
        tail = head
        var next = head?.next
        
        while next != nil {
            // Set next pointer to the previous node
            current?.next = previous
            // set current as previous for next loop
            previous = current
            current = next
            next = current?.next
        }
        
        current?.next = previous
        head = current
    }
    
    /// Returns a new reversed linked list .
    func reversed() -> LinkedList<T> {
        let copiedLinkedList = self.copy() as! LinkedList
        copiedLinkedList.reverse()
        return copiedLinkedList
    }
}
