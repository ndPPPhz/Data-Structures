//
//  BinaryTreeTests.swift
//  DataStructuresTests
//
//  Created by Annino De Petra on 07/03/2021.
//

import XCTest
@testable import DataStructures

final class BinaryTreeTests: XCTestCase {
    var tree = BinaryTree<Int>()
    
    func testBinaryTreeNotBinarySearchTree() {
        /*
            9
              \
                11
             /
            8
        */
        let root = BTNode(9)
        let rightRootNode = BTNode(11)
        let leftNodeToRightRootNode = BTNode(8)
        
        tree.root = root
        root.right = rightRootNode
        rightRootNode.left = leftNodeToRightRootNode
        
        XCTAssertFalse(tree.isBinarySearchTree, "Incorrect value returned. Binary tree is not a binary search tree too")
    }
    
    func testBinaryTreeAlsoBinarySearchTree() {
        /*
            9
              \
                11
             /
            10
        */
        let root = BTNode(9)
        let rightRootNode = BTNode(11)
        let leftNodeToRightRootNode = BTNode(10)
        
        tree.root = root
        root.right = rightRootNode
        rightRootNode.left = leftNodeToRightRootNode
        
        XCTAssertTrue(tree.isBinarySearchTree, "Incorrect value returned. Binary tree is also a binary search tree ")
    }
}
