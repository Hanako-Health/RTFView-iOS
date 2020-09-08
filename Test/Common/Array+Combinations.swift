//
//  Array+Combinations.swift
//  RTFView
//
//  Created by Marco Seidel on 23.07.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

extension Array {
	
	func combinations(count: Int = 2) -> [[Element]] {
		return ArraySlice(self).combinations(count: count)
	}
	
}

fileprivate extension ArraySlice {
	
	func combinations(count: Int) -> [[Element]] {
		guard count > 0 else { return [[]] }
		guard let first = first else { return [] }
		
		let head = [first]
		let subcombos = combinations(count: count - 1)
		var ret = subcombos.map { head + $0 }
		ret += dropFirst().combinations(count: count)
		
		return ret
	}
	
}
