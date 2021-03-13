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
    private var head: Node?
    private var tail: Node?
    
    /// Returns true if the queue doesn't store any element
    var isEmpty: Bool {
        return head == nil && tail == nil
    }
    
    // MARK: - Init
    init() {}
    
    // MARK: - Methods
    /// Adds data at the end of the queue
    ///
    /// Time complexity: O (1)
     func enqueue(_ data: T) {
        if head == nil {
            head = Node(data)
            tail = head
        } else {
            let tmpLastNode = tail
            tail = Node(data)
            tmpLastNode?.next = tail
        }
    }
    
    /// Removes the element on top of the queue
    ///
    /// Time complexity: O (1)
    @discardableResult
    func deque() -> T? {
        guard let currentHead = head else {
            return nil
        }
        // Set the new head
        head = currentHead.next
        
        // If the head was the only one element in the queue, set the tail to nil too
        if currentHead.next == nil {
            tail = nil
        }
        return currentHead.data
    }
}
