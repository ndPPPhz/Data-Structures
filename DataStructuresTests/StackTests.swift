//
//  StackTests.swift
//  DataStructuresTests
//
//  Created by Annino De Petra on 13/03/2021.
//

import XCTest
@testable import DataStructures

final class StackTests: XCTestCase {
    let stack = Stack<Int>()
    
    func testStackPopAndPush() {
        let range = 1..<4

        for i in range {
            stack.push(i)
            XCTAssertEqual(stack.top, i, "Incorrect top value retrieved")
        }
        
        let expectedReturnedElements = [3, 2, 1]
        var poppedElements = Array<Int>()
        
        while let element = stack.pop() {
            poppedElements.append(element)
        }
        
        XCTAssertEqual(poppedElements, expectedReturnedElements, "Elements returned from pop are incorrect")
        XCTAssertTrue(stack.isEmpty, "Stack must be empty")
        XCTAssertNil(stack.top, "Pop must return nil when stack is empty")
    }
    
    func testEmptyStack() {
        XCTAssertTrue(stack.isEmpty, "Stack must be empty")
        XCTAssertNil(stack.top, "Pop must return nil when stack is empty")
        XCTAssertNil(stack.pop(), "Pop must return nil when stack is empty")
    }
}
