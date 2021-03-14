//
//  Array+Extension.swift
//  DataStructures
//
//  Created by Annino De Petra on 14/03/2021.
//

import Foundation

extension Array where Element: Comparable {
    private func merge(leftHalf: Self, rightHalf: Self) -> Self {
        // Creates an array which contains both the left and the right half.
        guard let firstElement = leftHalf.first else {
            return []
        }
        
        let leftCount = leftHalf.count
        let rightCount = rightHalf.count
        
        // Since I cannot call init on Element, I am copying over the first element just to fill the array
        var returningArray = Self(repeating: firstElement, count: leftCount + rightCount)
        
        var mainIndex = 0
        var letfHalfIndex = 0
        var rightHalfIndex = 0
        
        while
            letfHalfIndex < leftCount,
            rightHalfIndex < rightCount
        {
            
            if leftHalf[letfHalfIndex] < rightHalf[rightHalfIndex] {
                returningArray[mainIndex] = leftHalf[letfHalfIndex]
                letfHalfIndex += 1
            } else {
                returningArray[mainIndex] = rightHalf[rightHalfIndex]
                rightHalfIndex += 1
            }
            mainIndex += 1
        }
        
        while letfHalfIndex < leftCount {
            returningArray[mainIndex] = leftHalf[letfHalfIndex]
            letfHalfIndex += 1
            mainIndex += 1
        }
        
        while rightHalfIndex < rightCount {
            returningArray[mainIndex] = rightHalf[rightHalfIndex]
            rightHalfIndex += 1
            mainIndex += 1
        }
        
        return returningArray
    }
    
    private func recursiveMergeSort(_ array: Self) -> Self {
        // Base exit condition
        if array.count < 2 {
            return array
        }
        
        // Divide the array in two halves
        let half = array.count / 2
        var leftHalf = Self(array[..<half])
        var rightHalf = Self(array[half...])
        
        // Recursive call on both left and right half
        // This recursive calls are being executed log(n) times
        leftHalf = recursiveMergeSort(leftHalf)
        rightHalf = recursiveMergeSort(rightHalf)
        
        // Merge the halves
        return merge(leftHalf: leftHalf, rightHalf: rightHalf)
    }
    
    
    /// Sorts the array using the merge sort algorithm
    ///
    /// Time complexity: O(n*log(n) )
    /// Space complexity: O(n)
    mutating func mergeSort() {
        self = recursiveMergeSort(self)
    }
}
