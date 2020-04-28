//
//  RandomNumberGenerator+Int.swift
//  RTFView_Example
//
//  Created by Marco Seidel on 28.04.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension RandomNumberGenerator {
	
	mutating func next(bound: Int) -> Int {
		Int(self.next(upperBound: UInt(bound)))
	}
	
}
