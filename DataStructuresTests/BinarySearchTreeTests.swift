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
    
    func testHeightMoreThan0() {
        
    }
}
