//
//  Node.swift
//  DataStructures
//
//  Created by Annino De Petra on 06/03/2021.
//

class BTNode<T> {
    let data: T
    var left: BTNode<T>?
    var right: BTNode<T>?
    
    init(_ data: T) {
        self.data = data
    }
}
