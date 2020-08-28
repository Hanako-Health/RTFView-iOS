//
//  SearchParserTest.swift
//  Pods-RTFView_Example
//
//  Created by Marco Seidel on 28.08.20.
//

import Foundation
import XCTest
import RTFView

class SearchParserTest: ParserTest {
	
	override var parser: Parser! { SearchParser() }
	
	override class var defaultTestSuite: XCTestSuite { XCTestSuite(forTestCaseClass: SearchParserTest.self) }
	
	func testPerformance() {
		measure {
			_ = parser.parse(input: measureInput)
		}
	}
	
}
