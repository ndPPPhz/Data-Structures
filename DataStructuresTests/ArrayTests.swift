//
//  ArrayTests.swift
//  DataStructuresTests
//
//  Created by Annino De Petra on 14/03/2021.
//

import XCTest
@testable import DataStructures

class ArrayTests: XCTestCase {
    // MARK: - Merge Sort
    func testMergeSort_oddNumberElements() {
        var testArray = [4, 11, 0, -3, 55, 92, 1]
        testArray.mergeSort()
        XCTAssertEqual([-3, 0, 1, 4, 11, 55, 92], testArray, "Elements order after merge sort is incorrect")
    }
    
    func testMergeSort_oddNumberElements_repeatedElements() {
        var testArray = [4, 11, 1, 0, -3, 55, 92, 1, -3]
        testArray.mergeSort()
        XCTAssertEqual([-3, -3, 0, 1, 1, 4, 11, 55, 92], testArray, "Elements order after merge sort is incorrect")
    }
    
    func testMergeSort_evenNumberElements() {
        var testArray = [4, 11, 0, -3, 55, 92, 1, 33]
        testArray.mergeSort()
        XCTAssertEqual([-3, 0, 1, 4, 11, 33, 55, 92], testArray, "Elements order after merge sort is incorrect")
    }
    
    func testMergeSort_oneElementArrayReturnsItself() {
        var testArray = [Int.max]
        testArray.mergeSort()
        XCTAssertEqual([Int.max], testArray, "Elements order after merge sort is incorrect")
    }
    
    func testMergeSort_emptyArray() {
        var testArray = Array<Int>()
        testArray.mergeSort()
        XCTAssertEqual([], testArray, "Empty array after merge sort returned a not empty array")
    }
    
    // MARK: - Quick Sort
    func testQuickSort_oddNumberElements() {
        var testArray = [4, 11, 0, -3, 55, 92, 1]
        testArray.quickSort()
        XCTAssertEqual([-3, 0, 1, 4, 11, 55, 92], testArray, "Elements order after quick sort is incorrect")
    }
    
    func testQuickSort_oddNumberElements_repeatedElements() {
        var testArray = [4, 11, 1, 0, -3, 55, 92, 1, -3]
        testArray.quickSort()
        XCTAssertEqual([-3, -3, 0, 1, 1, 4, 11, 55, 92], testArray, "Elements order after merge sort is incorrect")
    }
    
    func testQuickSort_evenNumberElements() {
        var testArray = [4, 11, 0, -3, 55, 92, 1, 33]
        testArray.quickSort()
        XCTAssertEqual([-3, 0, 1, 4, 11, 33, 55, 92], testArray, "Elements order after quick sort is incorrect")
    }
    
    func testQuickSort_oneElementArrayReturnsItself() {
        var testArray = [Int.max]
        testArray.quickSort()
        XCTAssertEqual([Int.max], testArray, "Elements order after quick sort is incorrect")
    }
    
    func testQuickSort_emptyArray() {
        var testArray = Array<Int>()
        testArray.quickSort()
        XCTAssertEqual([], testArray, "Empty array after quick sort returned a not empty array")
    }
}
