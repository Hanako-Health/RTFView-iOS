//
//  Parser.swift
//  RTFView
//
//  Created by Marco Seidel on 30.03.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation

public class FlatParser: RTFParser {
	static var TAG_START: Character = "["
	static var TAG_END: Character = "]"
	static var TAG_PARAMETER: Character = "="
	static var TAG_CLOSE: Character = "/"
	
	public init() {}
	
	public func parse(input: String) -> [Token] {
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
                case FlatParser.TAG_START:
                    if !content.isEmpty {
                        output += [Token(text: content, tags: activeTags)]
                        content = ""
                    }
                    tagInside = true
                case FlatParser.TAG_END:
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
                case FlatParser.TAG_CLOSE:
                    if !tagIdentifier.isEmpty {
                        let tag = Tag(type: tagIdentifier, parameter: p)
                        activeTags.append(tag)
                        output += [Token(text: "", tags: activeTags)]
                    }
                    tagClose = true
                case FlatParser.TAG_PARAMETER:
                    index += 1
                    tagParameter = input.dropFirst(index).prefix { !($0.isWhitespace || $0 == FlatParser.TAG_END) }.string
                    index += tagParameter!.count
                    continue
                default:
                    if tagInside {
                        if !char.isWhitespace {
                            tagIdentifier += char.string
                        }
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
