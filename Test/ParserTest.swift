//
//  ParserTest.swift
//  RTFView
//
//  Created by Marco Seidel on 28.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation
import XCTest
import RTFView

class ParserTest: XCTestCase {
	
	override class var defaultTestSuite: XCTestSuite { XCTestSuite(name: "Tests for protocols are excluded.") }
	
	var parser: Parser! { fatalError("No Parser instance provided!") }
	
	let measureInput = """
        [S2]
        First
        Second
        Third
        [/S2]
        """
	
	func testEmptyInput() {
		// Arrange
		let input = ""
		
		// Act
		let tokens = parser.parse(input: input)
	
		// Assert
		XCTAssert(tokens.isEmpty, "Empty input should result in an empty output.")
	}
	
	func testAutoclosingTag() {
		// Arrange
		let type = "IMG"
		let input = "[\(type) /]"
		
		// Act
		let tokens = parser.parse(input: input)
		
		// Assert
		XCTAssertEqual(tokens.count, 1, "Should be one token.")
		XCTAssertEqual(tokens.first?.tags.count, 1, "Token should contain only one tag.")
		XCTAssertEqual(tokens.first?.tags.first?.type, type, "Token type mismatching with input.")
	}
	
	func testAutoclosingTagWithParameter() {
		// Arrange
		let type = "IMG"
		let parameter = "Bundle"
		let input = "[\(type)=\(parameter) /]"
		
		// Act
		let tokens = parser.parse(input: input)
		
		// Assert
		XCTAssertEqual(tokens.count, 1, "Should be one token.")
		XCTAssertEqual(tokens.first?.tags.count, 1, "Token should contain only one tag.")
		XCTAssertEqual(tokens.first?.tags.first?.type, type, "Token type mismatching with input.")
		XCTAssertEqual(tokens.first?.tags.first?.parameter, parameter, "Token type mismatching with input.")
	}
	
	
	func testAllMissingBracketCombinations() {
		// Arrange
		let combinations = [false, true].combinations(count: 4)
			.filter { !($0.allSatisfy { $0 } || $0.allSatisfy { !$0 }) }
			.map { c in "Start" + "\(c[0] ? "[" : "")B\(c[1] ? "]" : "")" + "Middle\(c[2] ? "[" : "")/B\(c[3] ? "]" : "")" + "End" }
		
		// Act & Assert
		combinations.forEach {
			XCTAssertNoThrow(parser.parse(input: $0))
		}
	}
	
}
