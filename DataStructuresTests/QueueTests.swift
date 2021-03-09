//
//  DataStructuresTests.swift
//  DataStructuresTests
//
//  Created by Annino De Petra on 07/03/2021.
//

import XCTest
@testable import DataStructures

final class QueueTests: XCTestCase {
    
    func testQueueReturnsItemsInCorrectOrder() {
        let queue = Queue<Int>()
        
        let input = [4, 8, 11, 2]
        
        input.forEach {
            queue.enqueue($0)
        }

        var returnedItems = Array<Int>()
        
        while let data = queue.deque() {
            returnedItems.append(data)
        }
        
        XCTAssertTrue(queue.isEmpty, "Queue should be empty at this time")
        XCTAssertEqual(input, returnedItems, "Queue didn't respect the order")
    }
}

