/**
Parser.swift
RTFView

Created by Marco Seidel on 30.03.20.
Copyright © 2020 Envidual. All rights reserved.

FlatParser is a basic parser implementation. There are two formats supported:

1. Formatting with content: `[TAG]Content[/TAG]`
2. Self-closing formatting: `[TAG /]`
  This can be used for non-text like components, e. g. images.
  Note: The whitespace after the tag type is mandatory.

Though `[`, `]` and `/` are used as the special formatting characters in the example above, they're
completely configurable, so it's also possible to parse XML like formats: `<TAG>Content</TAG>`
Nethertheless, you should use a specialized XML parser for this type of parsing.

Due to performance issues, it internally uses the FastString implementation operating with pointers rather than
the actual String value type because of heavy copying.
*/
public class FlatParser: Parser {
	
	var characters: Characters
	
	public init(
		characters: Characters = .init()
	) {
		self.characters = characters
	}
	
	public func parse(input: String) -> [Token] {
		let input = FastString(input)
			
		var output = [Token]()
		var tags = [Tag]()
		
		var text = FastString()
		var type = FastString()
		var parameter: FastString? = nil
		var isInside = false
		var isClose = false
		var isParameter = false
		
		for char in input.makeCharacterIterator() {
			switch char {
				case characters.start:
					if text.characterCount != 0 {
						let t = text.toString() ?? ""
						let token = Token(text: t, tags: tags)
						output.append(token)
						text = FastString()
					}
					isInside = true
				case characters.end:
					if isInside {
						if isClose {
							let t = type.toString() ?? ""
							let index = tags.lastIndex { $0.type == t }
							if let index = index {
								tags.remove(at: index)
							}
						} else {
							let t = type.toString() ?? ""
							let p = parameter?.toString()
							let tag = Tag(type: t, parameter: p)
							tags.append(tag)
						}
					}
					
					type = FastString()
					parameter = nil
					isParameter = false
					isInside = false
					isClose = false
				case characters.close:
					// Detect self closing tag
					guard !isParameter else { continue }
					if type.characterCount != 0 {
						let t = type.toString() ?? ""
						let p = parameter?.toString()
						let tag = Tag(type: t, parameter: p)
						tags.append(tag)
						
						let token = Token(tags: tags)
						output.append(token)
					}
					isClose = true
				case characters.parameter:
					isParameter = true
				default:
					if isParameter {
						if char.isWhitespace {
							isParameter = false
						} else {
							if parameter == nil {
								parameter = FastString()
							}
							parameter!.append(char)
						}
					} else if isInside {
						if !char.isWhitespace {
							type.append(char)
						}
					} else {
						text.append(char)
					}
			}
		}
		
		if text.characterCount != 0 {
			let t = text.toString() ?? ""
			let token = Token(text: t)
			output.append(token)
		}
		
		return output
	}
	
}
