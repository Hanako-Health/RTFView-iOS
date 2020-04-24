//
//  Parser.swift
//  RTFView
//
//  Created by Marco Seidel on 30.03.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation

class Parser: RTFParser {
	static var TAG_START: Character = "["
	static var TAG_END: Character = "]"
	static var TAG_PARAMETER: Character = "="
	static var TAG_CLOSE: Character = "/"
	
	
	func parse(input: String) -> [Token] {		
		var output = [Token]()
		var activeTags = [Tag]()
		var content: String = ""
		
		
		var tagIdentifier = ""
		var tagParameter: String?
		var tagInside = false
		var tagClose = false
		
		var index = 0
		while index < input.count {
			let char = input[index] as Character
			
			
			switch char {
				case Parser.TAG_START:
					if !content.isEmpty {
						output += [Token(text: content, tags: activeTags)]
						content = ""
					}
					tagInside = true
					break
				case Parser.TAG_END:
					if tagInside {
						if tagClose {
							if let indexToRemove: Int = activeTags.lastIndex(where: { $0.type == tagIdentifier }) {
								activeTags.remove(at: indexToRemove)
							}
						} else {
							let tag = Tag(type: tagIdentifier, parameter: tagParameter)
							activeTags.append(tag)
						}
					}
					
					tagIdentifier = ""
					tagParameter = nil
					tagClose = false
					tagInside = false
					break
				case Parser.TAG_CLOSE:
					tagClose = true
					break
				case Parser.TAG_PARAMETER:
					index += 1
					let offset = input[index...].string
						.enumerated()
						.first { (index, s) in s == Parser.TAG_END }!
						.offset
	
					tagParameter = input[index..<(index + offset)].string
					index += offset
					continue
				default:
					if tagInside {
						tagIdentifier += char.string
					} else {
						content += char.string
					}
			}
			
			index += 1
		}
		
		if !content.isEmpty {
			output += [Token(text: content, tags: .init())]
		}
		
			
		return output
	}
	
	

}
