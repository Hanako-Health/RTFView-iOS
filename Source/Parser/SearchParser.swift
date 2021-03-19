//
//  SearchParser.swift
//  RTFView
//
//  Created by Marco Seidel on 27.08.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

public class SearchParser: Parser {
	
	public var characters: Characters
	
	public init(characters: Characters = .init()) {
		self.characters = characters
	}
		
	public func parse(input: String) -> [Token] {
		let length = input.count
		let input = FastString(input)
		
		// Collect indices of special characters
		let indicesStart = input.positions(character: characters.start)
		let indicesEnd = input.positions(character: characters.end)
		let indicesClose = input.positions(character: characters.close)
		let indicesParameter = input.positions(character: characters.parameter)
		let indicesWhitespace = input.positions(character: " ")
		
		var output = [Token]()
		var tags = [Tag]()
		
		// Handle unformatted start
		if let first = indicesStart.first, first > 0 {
			let range = 0..<first
			let text = input.subString(range: range).toString() ?? ""
			output.append(Token(text: text))
		}
		
		// MARK: - TAGS
		
		var operations = [(Int, Int, Int)]()
		for indexStart in indicesStart {
			let indexEnd = indicesEnd.first { indexStart < $0 } ?? length
			let indexCloseFirst = indicesClose.first {
				indexStart < $0 && $0 < indexEnd }
			let indexCloseLast = indicesClose.last {
				indexStart < $0 && $0 < indexEnd }
			let indexParameter = indicesParameter.first {
				indexStart < $0 && $0 < indexEnd }
			let indexWhitespace = indicesWhitespace.first {
				indexStart < $0 && $0 < indexEnd }
			
			let hasParameter = indexParameter != nil
			let closing = indexCloseFirst == indexStart + 1
			let selfClosing = indexCloseLast == indexEnd - 1
			
			
			if closing {
				// If closing save the index for the pop operation
				
				let indexTypeStart = indexCloseFirst! + 1
				let indexTypeEnd = (indexWhitespace ?? indexEnd)
				let range = indexTypeStart..<indexTypeEnd
				let type = input.subString(range: range).toString() ?? ""
				
				// Find index in reverse and save for delete
				if let indexTag = tags.lastIndex(where: {
					$0 != nil && $0!.type == type }) {
					
					operations.append((0, indexStart, indexTag))
				}
			} else {
				// Find all ranges to save tag
				let indexTypeStart: Int
				let indexTypeEnd: Int
				let indexParameterStart: Int?
				let indexParameterEnd: Int?
				
				// Detect type start
				indexTypeStart = indexStart + 1
				
				// Detect type end
				if hasParameter {
					indexTypeEnd = indexParameter!
				} else if let i = indexWhitespace {
					indexTypeEnd = i
				} else if selfClosing {
					indexTypeEnd = indexCloseLast!
				} else {
					indexTypeEnd = indexEnd
				}
				
				// Detect parameter start
				if let i = indexParameter {
					indexParameterStart = i + 1
				} else {
					indexParameterStart = nil
				}
				
				// Detect parameter End
				if indexParameterStart == nil {
					indexParameterEnd = nil
				} else if let i = indexWhitespace {
					indexParameterEnd = i
				} else if selfClosing {
					indexParameterEnd = indexCloseLast!
				} else {
					indexParameterEnd = indexEnd
				}
				
				
				// Create type
				let range = indexTypeStart..<indexTypeEnd
				let type = input.subString(range: range).toString() ?? ""
				
				// Create parameter
				let parameter: String?
				if let start = indexParameterStart,
					let end = indexParameterEnd {
					
					let range = start..<end
					parameter = input.subString(range: range).toString() ?? ""
				} else {
					parameter = nil
				}
				
				
				// Find or insert
				let indexTag: Int
				
				if let i = tags.firstIndex(where: {
					$0 != nil && $0!.type == type && $0!.parameter == parameter
				}) {
					indexTag = i
				} else {
					let tag = Tag(type: type, parameter: parameter)
					tags.append(tag)
					
					indexTag = tags.count - 1
				}
				
				operations.append((selfClosing ? 2 : 1, indexStart, indexTag))
			}
		}
		
		// MARK: - TOKENS
		
		var stack = [Int]()
		var lastIndex = 0
		
		for i in indicesEnd {
			let indexStart = i + 1
			let indexEnd = indicesStart.first { indexStart < $0 } ?? length
			
			for (op, index, indexTag) in operations
				where index >= lastIndex && index < indexStart {

				if op == 0 { // Delete
					stack.removeLast()
				} else if op == 1 { // Insert
					stack.append(indexTag)
				} else if op == 2 { // Autoclose
					stack.append(indexTag)
					let tags = stack.compactMap { $0 == nil ? nil : tags[$0!] }
					let token = Token(tags: tags)
					output.append(token)
					stack.removeLast()
				}
			}
			
			if indexStart < indexEnd {
				let range = indexStart..<indexEnd
				let content = input.subString(range: range).toString() ?? ""
				let tags = stack.compactMap { $0 == nil ? nil : tags[$0!] }
				let token = Token(text: content, tags: tags)
				output.append(token)
			}
		
			lastIndex = indexEnd
		}
				
		// Handle unformatted end
		if let last = indicesEnd.last, last < length - 1 {
			let range = (last + 1)..<length
			let text = input.subString(range: range).toString() ?? ""
			output.append(Token(text: text))
		}
		
		return output
	}
	
}
