//
//  Queue.swift
//  DataStructures
//
//  Created by Annino De Petra on 06/03/2021.
//

 class Queue<T> {
    class Node<T> {
        let data: T
        var next: Node<T>?
        
        init(_ data: T) {
            self.data = data
        }
    }
    
    init() {}
    
    var isEmpty: Bool {
        return first == nil
    }
    
    var first: Node<T>?
    var last: Node<T>?
    
     func add(_ data: T) {
        if first == nil {
            first = Node(data)
            last = first
        } else {
            let tmpLast = last
            last = Node(data)
            tmpLast?.next = last
        }
    }
    
    func deque() -> T? {
        guard let tmpFirst = first else {
            return nil
        }
        
        first = tmpFirst.next
        return tmpFirst.data
    }
}
