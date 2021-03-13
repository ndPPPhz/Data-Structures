//
//  Queue.swift
//  DataStructures
//
//  Created by Annino De Petra on 06/03/2021.
//

 final class Queue<T> {
    class Node {
        let data: T
        var next: Node?
        
        init(_ data: T) {
            self.data = data
        }
    }
    
    // MARK: - Properties
    private var firstNode: Node?
    private var lastNode: Node?
    
    /// Returns true if the queue doesn't store any element
    var isEmpty: Bool {
        return firstNode == nil
    }
    
    // MARK: - Init
    init() {}
    
    // MARK: - Methods
    /// Adds data at the end of the queue
    ///
    /// Time complexity: O (1)
     func enqueue(_ data: T) {
        if firstNode == nil {
            firstNode = Node(data)
            lastNode = firstNode
        } else {
            let tmpLastNode = lastNode
            lastNode = Node(data)
            tmpLastNode?.next = lastNode
        }
    }
    
    /// Removes the element on top of the queue
    ///
    /// Time complexity: O (1)
    @discardableResult
    func deque() -> T? {
        guard let tmpFirstNode = firstNode else {
            return nil
        }
        
        firstNode = tmpFirstNode.next
        return tmpFirstNode.data
    }
}
