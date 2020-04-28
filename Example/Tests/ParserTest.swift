//
//  ParserTest.swift
//  RTFView_Example
//
//  Created by Marco Seidel on 28.04.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
import RTFView

class ParserTest: XCTestCase {
	
	var parser: RTFParser { nil! }
	var rng: RandomNumberGenerator = SystemRandomNumberGenerator()
	
	func testEmptyTags() {
		let s = "[IMG=Bundle /]"
		let t = parser.parse(input: s)
		
		XCTAssert(t.count == 1)
		XCTAssert(t.first!.tags.count == 1)
		XCTAssert(t.first!.tags.first!.type == "IMG")
		XCTAssert(t.first!.tags.first!.parameter == "Bundle")
	}
	
}
