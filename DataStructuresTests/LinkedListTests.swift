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
        let range = 1..<4
        for i in range {
            linkedList.append(i)
        }
        
        var traversalElements = Array<Int>()
        let expectedElements = Array<Int>(range)
        
        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, expectedElements, "Linked list traversal order is incorrect")
    }
    
    func testRemoveItemFromLinkedList() {
        let range = 1..<4
        for i in range {
            linkedList.append(i)
        }
        
        var traversalElements = Array<Int>()
        let expectedElements = [1, 3]
        
        linkedList.remove(2)
        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, expectedElements, "Incorrect linked list found after deleting an element")
    }
    
    func testRemoveNotPresentElementFromLinkedListDoesntAffectLinkedList() {
        let range = 1..<4
        for i in range {
            linkedList.append(i)
        }
        
        var traversalElements = Array<Int>()
        let expectedElements = Array<Int>(range)

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
        let range = 1..<4
        for i in range {
            linkedList.append(i)
        }
        
        var traversalElements = Array<Int>()
        let expectedElements = [2, 3]
        
        linkedList.remove(1)
        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, expectedElements, "Incorrect linked list found after deleting its head node")
    }
    
    func testRemoveHeadFromOneElementLinkedList() {
        linkedList.append(1)
        
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
        let range = 1..<4
        for i in range {
            linkedList.append(i)
        }
        
        let didFindThree = linkedList.search(3)
        XCTAssertTrue(didFindThree, "Value 3 not found in the linkedlist")
    }
    
    func testSearchNotPresentElementInLinkedList() {
        let range = 1..<4
        for i in range {
            linkedList.append(i)
        }
        
        let didFindFour = linkedList.search(4)
        XCTAssertFalse(didFindFour, "Value 4 unexpectedly found in the linked list")
    }
    
    func testLinkedListReversedTraverse() {
        let range = 1..<4
        for i in range {
            linkedList.append(i)
        }
        
        var reversedTraversalElements = Array<Int>()
        let expectedElements = Array<Int>(range.reversed())

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
    
    func testReverseLinkedList() {
        let range = 0 ..< 10
        for i in range {
            linkedList.append(i)
        }
        
        linkedList.reverse()
        
        var traversalElementsAfterReverse = Array<Int>()
        
        var expectedElements = Array<Int>(range)
        expectedElements.reverse()
        
        linkedList.traverse {
            traversalElementsAfterReverse.append($0.data)
        }
        
        XCTAssertEqual(traversalElementsAfterReverse, expectedElements, "Linked list traversal order is incorrect after reversing the linked list")
        XCTAssertEqual(linkedList.tail?.data, 0, "Incorrect value found stored in the linked list tail after reversing")
        XCTAssertNil(linkedList.tail?.next, "Found a stored node after the linked list tail after reversing")
    }
    
    func testLinkedListCopyReturnsNewLinkedList_NewPointers() {
        let range = 0 ..< 10
        for i in range {
            linkedList.append(i)
        }
        
        let copiedLinkedList = linkedList.copy() as! LinkedList<Int>
        
        XCTAssertTrue(copiedLinkedList !== linkedList, "Copied linked list shares same pointer of the original one")
        
        var linkedListIterator = linkedList.head
        var copiedLinkedListIterator = copiedLinkedList.head
        
        while
            let notNilLinkedListIterator = linkedListIterator,
            let notNilCopiedLinkedListIterator = copiedLinkedListIterator
        {
            XCTAssertEqual(linkedListIterator?.data, copiedLinkedListIterator?.data, "Different data found at \(notNilLinkedListIterator) - \(notNilCopiedLinkedListIterator) after cloning the linked list")
            
            if
                let nextLinkedListIteratorNode = linkedListIterator?.next,
                let nextCopiedLinkedListIteratorNode = copiedLinkedListIterator?.next
            {
                XCTAssertTrue(nextLinkedListIteratorNode !== nextCopiedLinkedListIteratorNode, "Different data found at \(nextLinkedListIteratorNode) - \(nextCopiedLinkedListIteratorNode) after cloning the linked list")
            }
            linkedListIterator = linkedListIterator?.next
            copiedLinkedListIterator = copiedLinkedListIterator?.next
        }
    }
    
    func testReversedLinkedListReturnsANewReversedLinkedList() {
        let range = 0 ..< 10
        for i in range {
            linkedList.append(i)
        }

        let newReversedLinkedList = linkedList.reversed()

        var traversalElements = Array<Int>()
        var reversedTraversalElements = Array<Int>()

        linkedList.traverse {
            traversalElements.append($0.data)
        }
        
        newReversedLinkedList.traverse {
            reversedTraversalElements.append($0.data)
        }
        
        XCTAssertEqual(traversalElements, reversedTraversalElements.reversed(), "Reversed Linked List returned incorrect values")
    }
}
