//
//  ArrayTests.swift
//  DataStructuresTests
//
//  Created by Annino De Petra on 14/03/2021.
//

import XCTest
@testable import DataStructures

class ArrayTests: XCTestCase {
    
    func testMergeSort_oddNumberElements() {
        var testArray = [4, 11, 0, -3, 55, 92, 1]
        testArray.mergeSort()
        XCTAssertEqual([-3, 0, 1, 4, 11, 55, 92], testArray, "Elements order after merge sorted is incorrect")
    }
    
    func testMergeSort_evenNumberElements() {
        var testArray = [4, 11, 0, -3, 55, 92, 1, 33]
        testArray.mergeSort()
        XCTAssertEqual([-3, 0, 1, 4, 11, 33, 55, 92], testArray, "Elements order after merge sorted is incorrect")
    }
    
    func testMergeSort_oneElementArrayReturnsItself() {
        var testArray = [Int.max]
        testArray.mergeSort()
        XCTAssertEqual([Int.max], testArray, "Elements order after merge sorted is incorrect")
    }
    
    func testMergeSort_emptyArray() {
        var testArray = Array<Int>()
        testArray.mergeSort()
        XCTAssertEqual([], testArray, "Empty array after merge sorted returned a not empty array")
    }
}
