//
//  Tree.swift
//  DataStructures
//
//  Created by Annino De Petra on 05/03/2021.
//

import Foundation

enum Traversal {
    case inorder, preorder, postorder, breadth
}

protocol Tree {
    associatedtype T
    
    var root: BTNode<T>? { get }
}
