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
    }
    
    private(set) var head: Node?
    private(set) var tail: Node?
    
    init() {}
    
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
}
