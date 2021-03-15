//
//  TrieTests.swift
//  DataStructuresTests
//
//  Created by Annino De Petra on 15/03/2021.
//

import XCTest
@testable import DataStructures

final class TrieTests: XCTestCase {
    lazy var contactsTrie = Trie<Character, String>()

    func testTrieFindsWords() {
        let contacts = [
            "Jack",
            "Chris",
            "Christos",
            "Dad"
        ]
        
        for contact in contacts {
            contactsTrie.insert(contact)
        }

        XCTAssertTrue(contactsTrie.find("Chris"), "Chris is a valid contact")
        XCTAssertFalse(contactsTrie.find("Chri"), "Chri is an invalid contact")
    }
    
    func testTrieReturnsCorrectWordCount() {
        let contacts = [
            "C",
            "Jack",
            "Chris",
            "Christos",
            "Dad"
        ]
        
        for contact in contacts {
            contactsTrie.insert(contact)
        }

        XCTAssertEqual(contactsTrie.count(for: "Chri"), 2, "There are two contacts containing Chri")
        XCTAssertEqual(contactsTrie.count(for: "Chris"), 2, "There are two contacts containing Chris")
        XCTAssertEqual(contactsTrie.count(for: "C"), 3, "There are three contacts containing C")
    }
    
    func testTriesSameWordInsertionDoesntIncreaseCount() {
        let contacts = [
            "Jack",
            "Jack",
            "Jack",
            "Dad"
        ]
        
        for contact in contacts {
            contactsTrie.insert(contact)
        }
        
        XCTAssertTrue(contactsTrie.find("Jack"), "Jack is a valid word")
        XCTAssertEqual(contactsTrie.count(for: "Jack"), 1, "Jack is only contained once")
        
        contactsTrie.insert("Jack Daniel")
        
        XCTAssertEqual(contactsTrie.count(for: "Jack"), 2, "Jack is contained twice")
    }
}
