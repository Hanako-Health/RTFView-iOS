//
//  RandomNumberGenerator+Int.swift
//  RTFView
//
//  Created by Marco Seidel on 28.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

extension RandomNumberGenerator {
	
	mutating func next(bound: Int) -> Int {
		Int(self.next(upperBound: UInt(bound)))
	}
	
}
