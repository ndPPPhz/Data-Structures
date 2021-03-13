//
//  Stack.swift
//  DataStructures
//
//  Created by Annino De Petra on 13/03/2021.
//

import Foundation

final class Stack<T: Equatable> {
    // MARK: - Init
    init() {
        list = LinkedList()
    }
    
    // MARK: - Properties
    private let list: LinkedList<T>

    
    /// Returns the element stored on top of the stack
    var top: T? {
        return list.head?.data
    }
    
    /// Returns true if the stack doesn't store any element
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    // MARK: - Methods
    /// Adds data to the stack
    ///
    /// Time complexity: O (1)
    func push(_ data: T) {
        list.add(data)
    }
    
    func pop() -> T? {
        return list.removeFirstNode()
    }
}

// MARK: - Linked list extension
private extension LinkedList {
    /// Removes the head node of the linked list if exists.
    /// - Returns: Node's data if the list is not empty . Nil otherwise.
    ///
    /// Time complexity: O (N)
    func removeFirstNode() -> T? {
        guard let head = head else {
            return nil
        }
        
        remove(head.data)
        return head.data
    }
}
