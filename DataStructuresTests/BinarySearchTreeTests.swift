//
//  BinarySearchTreeTests.swift
//  DataStructuresTests
//
//  Created by Annino De Petra on 07/03/2021.
//

import XCTest
@testable import DataStructures

final class BinarySearchTreeTests: XCTestCase {
    
    lazy var tree = BinarySearchTree<Int>()
    lazy var emptyTree = BinarySearchTree<Int>()
    
    override func setUp() {
        /*
                                50
                        /              \
                      30                 70
                    /    \              /
                  20     40            60
                /                     /
              10                    52
                                      \
                                       55
         */
        
        let nodes = [50, 30, 40, 70, 20, 60, 52, 10, 55]
        nodes.forEach {
            tree.insert($0)
        }
    }
    
    func testBinarySearchTreeInorderTraversal() {
        let expectedInorderTraversal = [10, 20, 30, 40, 50, 52, 55, 60, 70]
        var returnedTraversal = Array<Int>()
        
        tree.traversal(.inorder) {
            returnedTraversal.append($0.data)
        }
        
        XCTAssertEqual(expectedInorderTraversal, returnedTraversal, "Incorrect Inorder traversal order returned")
    }
    
    func testBinarySearchTreePreorderTraversal() {
        let expectedPreorderTraversal = [50, 30, 20, 10, 40, 70, 60, 52, 55]
        var returnedTraversal = Array<Int>()
        
        tree.traversal(.preorder) {
            returnedTraversal.append($0.data)
        }
        
        XCTAssertEqual(expectedPreorderTraversal, returnedTraversal, "Incorrect Preorder traversal order returned")
    }
    
    func testBinarySearchTreePostorderTraversal() {
        let expectedPostorderTraversal = [10, 20, 40, 30, 55, 52, 60, 70, 50]
        var returnedTraversal = Array<Int>()
        
        tree.traversal(.postorder) {
            returnedTraversal.append($0.data)
        }
        
        XCTAssertEqual(expectedPostorderTraversal, returnedTraversal, "Incorrect Postorder traversal order returned")
    }

    func testBinarySearchTreeBreadthTraversal() {
        let expectedBreadthTraversal = [50, 30, 70, 20, 40, 60, 10, 52, 55]
        var returnedTraversal = Array<Int>()
        
        tree.traversal(.breadth) {
            returnedTraversal.append($0.data)
        }
        
        XCTAssertEqual(expectedBreadthTraversal, returnedTraversal, "Incorrect Breadth traversal order returned")
    }
    
    func testEmptyBinarySearchTreeInorderTraversal() {
        var returnedTraversal = Array<Int>()
        
        emptyTree.traversal(.inorder) {
            returnedTraversal.append($0.data)
        }
        
        XCTAssertTrue(returnedTraversal.isEmpty, "Traversal found element/s in an empty tree")
    }
    
    func testEmptyBinarySearchTreePreorderTraversal() {
        var returnedTraversal = Array<Int>()
        
        emptyTree.traversal(.preorder) {
            returnedTraversal.append($0.data)
        }
        
        XCTAssertTrue(returnedTraversal.isEmpty, "Traversal found element/s in an empty tree")
    }
    
    func testEmptyBinarySearchTreePostorderTraversal() {
        var returnedTraversal = Array<Int>()
        
        emptyTree.traversal(.postorder) {
            returnedTraversal.append($0.data)
        }
        
        XCTAssertTrue(returnedTraversal.isEmpty, "Traversal found element/s in an empty tree")
    }

    func testEmptyBinarySearchTreeBreadthTraversal() {
        var returnedTraversal = Array<Int>()
        
        emptyTree.traversal(.breadth) {
            returnedTraversal.append($0.data)
        }
        
        XCTAssertTrue(returnedTraversal.isEmpty, "Traversal found element/s in an empty tree")
    }
    
    func testBinarySearch() {
        let inArrayItems = [20, 55, 70, 40]
        inArrayItems.forEach {
            XCTAssertTrue(tree.search($0), "Item \($0) not found in tree")
        }
        
        let notInArrayItems = [21, 53, 0, -1]
        notInArrayItems.forEach {
            XCTAssertFalse(tree.search($0), "Item \($0) found in tree")
        }
    }
    
    func testBinarySearchEmptyTree() {
        let elements = [20, 55, 70, 40]
        elements.forEach {
            XCTAssertFalse(emptyTree.search($0), "Item \($0) found in empty tree")
        }
    }
    
    func testHeightMoreThan0() {
        XCTAssertEqual(4, tree.height, "Incorrect height returned")
    }
    
    func testEmptyTreeHeight() {
        XCTAssertEqual(0, emptyTree.height, "Height with no root must return height 0")
    }
    
    func testBinarySearchTreeMinValue() {
        XCTAssertEqual(tree.min, 10, "Incorrect min value returned")
    }
    
    func testBinarySearchTreeMaxValue() {
        XCTAssertEqual(tree.max, 70, "Incorrect max value returned")
    }
}
