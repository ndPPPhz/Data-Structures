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
    
    func testBinarySearchTreeMinValue_emptyTree() {
        let emptyTree = BinarySearchTree<Int>()
        XCTAssertNil(emptyTree.min, "Min value must not exist on an empty tree")
    }
    
    func testBinarySearchTreeMaxValue() {
        XCTAssertEqual(tree.max, 70, "Incorrect max value returned")
    }
    
    func testBinarySearchTreeMaxValue_emptyTree() {
        let emptyTree = BinarySearchTree<Int>()
        XCTAssertNil(emptyTree.max, "Max value must not exist on an empty tree")
    }
    
    func testDeleteLeafNode_10() {
        XCTAssertTrue(tree.search(10), "Node not found")
        XCTAssertTrue(tree.delete(10), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(tree.search(10), "Node found after deletion")
        XCTAssertTrue(tree.isBinarySearchTree, "Tree is no longer a BST")
        XCTAssertEqual(tree.height, 4, "Tree height should not change")
        
        let expectedBreadthTraversal = [50, 30, 70, 20, 40, 60, 52, 55]
        var returnedBreadthTraversal = Array<Int>()
        tree.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteLeafNode_55() {
        XCTAssertTrue(tree.search(55), "Node not found")
        XCTAssertTrue(tree.delete(55), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(tree.search(55), "Node found after deletion")
        XCTAssertTrue(tree.isBinarySearchTree, "Tree is no longer a BST")
        XCTAssertEqual(tree.height, 3, "Tree height should change after deleting")
        
        let expectedBreadthTraversal = [50, 30, 70, 20, 40, 60, 10, 52]
        var returnedBreadthTraversal = Array<Int>()
        tree.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteNodeWithOneChild_left_20() {
        XCTAssertTrue(tree.search(20), "Node not found")
        XCTAssertTrue(tree.delete(20), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(tree.search(20), "Node found after deletion")
        XCTAssertTrue(tree.isBinarySearchTree, "Tree is no longer a BST")
        XCTAssertEqual(tree.height, 4, "Tree height should not change after deleting")
        
        let expectedBreadthTraversal = [50, 30, 70, 10, 40, 60, 52, 55]
        var returnedBreadthTraversal = Array<Int>()
        tree.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteNodeWithOneChild_left_52() {
        XCTAssertTrue(tree.search(52), "Node not found")
        XCTAssertTrue(tree.delete(52), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(tree.search(52), "Node found after deletion")
        XCTAssertTrue(tree.isBinarySearchTree, "Tree is no longer a BST")
        XCTAssertEqual(tree.height, 3, "Tree height should change after deleting")
        
        let expectedBreadthTraversal = [50, 30, 70, 20, 40, 60, 10, 55]
        var returnedBreadthTraversal = Array<Int>()
        tree.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteRoot_withLeftAndRightSubtrees_50() {
        XCTAssertTrue(tree.search(50), "Node not found")
        XCTAssertTrue(tree.delete(50), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(tree.search(50), "Node found after deletion")
        XCTAssertTrue(tree.isBinarySearchTree, "Tree is no longer a BST")
        XCTAssertEqual(tree.height, 3, "Tree height should change after deleting")
        
        let expectedBreadthTraversal = [52, 30, 70, 20, 40, 60, 10, 55]
        var returnedBreadthTraversal = Array<Int>()
        tree.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteNode_withLeftAndRightSubtrees_30() {
        XCTAssertTrue(tree.search(30), "Node not found")
        XCTAssertTrue(tree.delete(30), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(tree.search(30), "Node found after deletion")
        XCTAssertTrue(tree.isBinarySearchTree, "Tree is no longer a BST")
        XCTAssertEqual(tree.height, 4, "Tree height should not change after deleting")
        
        let expectedBreadthTraversal = [50, 40, 70, 20, 60, 10, 52, 55]
        var returnedBreadthTraversal = Array<Int>()
        tree.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteNodeWithRootAndWithOneLinkedNode_left(){
        let treeWithRootAndOneChild = BinarySearchTree<Int>()
        treeWithRootAndOneChild.insert(10)
        treeWithRootAndOneChild.insert(8)
        
        XCTAssertTrue(treeWithRootAndOneChild.search(8), "Node not found")
        XCTAssertTrue(treeWithRootAndOneChild.delete(8), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(treeWithRootAndOneChild.search(8), "Node found after deletion")

        let expectedBreadthTraversal = [10]
        var returnedBreadthTraversal = Array<Int>()
        treeWithRootAndOneChild.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteNodeWithRootWithOneLinkedNode_right(){
        let treeWithRootAndOneChild = BinarySearchTree<Int>()
        treeWithRootAndOneChild.insert(10)
        treeWithRootAndOneChild.insert(11)
        
        XCTAssertTrue(treeWithRootAndOneChild.search(11), "Node not found")
        XCTAssertTrue(treeWithRootAndOneChild.delete(11), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(treeWithRootAndOneChild.search(11), "Node found after deletion")

        let expectedBreadthTraversal = [10]
        var returnedBreadthTraversal = Array<Int>()
        treeWithRootAndOneChild.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteRootWithOneLinkedNode_left(){
        let treeWithRootAndOneChild = BinarySearchTree<Int>()
        treeWithRootAndOneChild.insert(10)
        treeWithRootAndOneChild.insert(8)
        
        XCTAssertTrue(treeWithRootAndOneChild.search(10), "Node not found")
        XCTAssertTrue(treeWithRootAndOneChild.delete(10), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(treeWithRootAndOneChild.search(10), "Node found after deletion")

        let expectedBreadthTraversal = [8]
        var returnedBreadthTraversal = Array<Int>()
        treeWithRootAndOneChild.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteRootWithOneLinkedNode_right(){
        let treeWithRootAndOneChild = BinarySearchTree<Int>()
        treeWithRootAndOneChild.insert(10)
        treeWithRootAndOneChild.insert(11)
        
        XCTAssertTrue(treeWithRootAndOneChild.search(10), "Node not found")
        XCTAssertTrue(treeWithRootAndOneChild.delete(10), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(treeWithRootAndOneChild.search(10), "Node found after deletion")

        let expectedBreadthTraversal = [11]
        var returnedBreadthTraversal = Array<Int>()
        treeWithRootAndOneChild.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteRoot(){
        let onlyRootTree = BinarySearchTree<Int>()
        onlyRootTree.insert(10)
        
        XCTAssertTrue(onlyRootTree.search(10), "Node not found")
        XCTAssertTrue(onlyRootTree.delete(10), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(onlyRootTree.search(10), "Node found after deletion")

        let expectedBreadthTraversal = Array<Int>()
        var returnedBreadthTraversal = Array<Int>()
        onlyRootTree.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteNotExistingNode_deleteReturnsFalse_treeDidNotChange(){
        XCTAssertFalse(tree.search(99), "Found a not existing node in the tree")
        XCTAssertFalse(tree.delete(99), "Delete function could not remove the node from within the tree")
        XCTAssertFalse(tree.search(99), "Found a not existing node in the tree")
        
        XCTAssertTrue(tree.isBinarySearchTree, "Tree is no longer a BST")
        XCTAssertEqual(tree.height, 4, "Tree height should not change")
        
        let expectedBreadthTraversal = [50, 30, 70, 20, 40, 60, 10, 52, 55]
        var returnedBreadthTraversal = Array<Int>()
        tree.traversal(.breadth) {
            returnedBreadthTraversal.append($0.data)
        }
        XCTAssertEqual(expectedBreadthTraversal, returnedBreadthTraversal, "Incorrect breadth traversal returned after deletion")
    }
    
    func testDeleteOnEmptyTree(){
        let onlyRootTree = BinarySearchTree<Int>()
        onlyRootTree.insert(10)
        onlyRootTree.delete(10)
        
        XCTAssertFalse(onlyRootTree.delete(10), "Calling delete on an empty tree must return false")
    }
}
