//
//  LinkedListTests.swift
//  DataStructuresTests
//
//  Created by Annino De Petra on 13/03/2021.
//

import XCTest
@testable import DataStructures

final class LinkedListTests: XCTestCase {
    var linkedList = LinkedList<Int>()
    
    func testAddingNodeAtEnd() {
        linkedList.add(1)
        linkedList.add(2)
        linkedList.add(3)
        
        var traversalElements = Array<Int>()
        let expectedElements = [1, 2, 3]
        
        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, expectedElements, "Linked list traversal order is incorrect")
    }
    
    func testRemoveItemFromLinkedList() {
        linkedList.add(1)
        linkedList.add(2)
        linkedList.add(3)
        
        var traversalElements = Array<Int>()
        let expectedElements = [1, 3]
        
        linkedList.remove(2)
        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, expectedElements, "Incorrect linked list found after deleting an element")
    }
    
    func testRemoveNotPresentElementFromLinkedListDoesntAffectLinkedList() {
        linkedList.add(1)
        linkedList.add(2)
        linkedList.add(3)
        
        var traversalElements = Array<Int>()
        let expectedElements = [1, 2, 3]
        
        linkedList.remove(99)
        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, expectedElements, "Incorrect linked list found after try to delete an element that doesn't exist")
        XCTAssertEqual(linkedList.head?.data, 1, "Head has an incorrect value after try to delete an element that doesn't exist")
        XCTAssertEqual(linkedList.head?.next?.data, 2, "Node has an incorrect value after try to delete an element that doesn't exist")
        XCTAssertEqual(linkedList.tail?.data, 3, "Tail has an incorrect value after try to delete an element that doesn't exist")
        XCTAssertNil(linkedList.tail?.next, "Tail's next value must be nil")
    }
    
    func testRemoveHeadFromLinkedList() {
        linkedList.add(1)
        linkedList.add(2)
        linkedList.add(3)
        
        var traversalElements = Array<Int>()
        let expectedElements = [2, 3]
        
        linkedList.remove(1)
        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, expectedElements, "Incorrect linked list found after deleting its head node")
    }
    
    func testRemoveHeadFromOneElementLinkedList() {
        linkedList.add(1)
        
        var traversalElements = Array<Int>()
        
        linkedList.remove(1)
        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, [], "Incorrect linked list found after deleting its head node")
        XCTAssertNil(linkedList.head, "Head must be nil after deleting linked list's only one node")
        XCTAssertNil(linkedList.tail, "Tail must be nil after deleting linked list's only one node")
    }
    
    func testRemoveFromEmptyLinkedList() {
        var traversalElements = Array<Int>()
        
        linkedList.remove(99)
        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, [], "Incorrect linked list found after deleting its head node")
        XCTAssertNil(linkedList.head, "Head must be nil in an empty linked list")
        XCTAssertNil(linkedList.tail, "Tail must be nil in an empty linked list")
    }
    
    func testSearchLinkedList() {
        linkedList.add(1)
        linkedList.add(2)
        linkedList.add(3)
        
        let didFindThree = linkedList.search(3)
        XCTAssertTrue(didFindThree, "Value 3 not found in the linkedlist")
    }
    
    func testSearchNotPresentElementInLinkedList() {
        linkedList.add(1)
        linkedList.add(2)
        linkedList.add(3)
        
        let didFindFour = linkedList.search(4)
        XCTAssertFalse(didFindFour, "Value 4 unexpectedly found in the linked list")
    }
    
    func testLinkedListReversedTraverse() {
        linkedList.add(1)
        linkedList.add(2)
        linkedList.add(3)
        
        var reversedTraversalElements = Array<Int>()
        let expectedElements = [3, 2, 1]
        
        linkedList.reversedTraverse {
            reversedTraversalElements.append($0.data)
        }
        
        XCTAssertEqual(reversedTraversalElements, expectedElements, "Reversed traversal returned items in an incorrect order")
    }
    
    func testLinkedListWithCycles_hasCyclesReturnsTrue() {
        var currentNode = LinkedList<Int>.Node(0)
        let head = currentNode
        linkedList.setNewHead(head)
        
        for i in 1..<10 {
            let node = LinkedList<Int>.Node(i)
            currentNode.next = node
            currentNode = node
        }
        
        currentNode.next = head
        
        XCTAssertTrue(linkedList.hasCycles, "Cycle inspection returned false in a linked list with a loop")
    }
    
    func testLinkedListWithoutCycles_hasCyclesReturnsFalse() {
        var currentNode = LinkedList<Int>.Node(0)
        let head = currentNode
        linkedList.setNewHead(head)
        
        for i in 1..<10 {
            let node = LinkedList<Int>.Node(i)
            currentNode.next = node
            currentNode = node
        }
                
        XCTAssertFalse(linkedList.hasCycles, "Cycle inspection found out a cycle in a linked list without a loop")
    }
}
