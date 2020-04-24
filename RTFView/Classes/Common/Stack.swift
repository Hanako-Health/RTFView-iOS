//
//  Stack.swift
//  RTFView
//
//  Created by Marco Seidel on 30.03.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation

struct Stack<T> {
	var content = [T]()
	
	@discardableResult
	mutating func pop() -> T? {
		content.popLast()
	}
	
	@discardableResult
	mutating func peek() -> T? {
		content.last
	}
	
	mutating func push(_ element: T) {
		content.append(element)
	}
	
	mutating func isEmpty() -> Bool {
		content.isEmpty
	}
	
}
