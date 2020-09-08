//
//  TreeToken.swift
//  RTFView
//
//  Created by Marco Seidel on 12.06.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation
import UIKit

public struct TreeToken {
    public let type: String
    public let parameter: String?
    public let children: [TreeToken]
	
	public init(type: String = "", parameter: String? = nil, children: [TreeToken] = []) {
		self.type = type
		self.parameter = parameter
		self.children = children
	}
	
}

public protocol Parse {
	
	func parse(_ input: String) -> TreeToken
	
}
	
public protocol Build {
		
	func build(for token: TreeToken) -> UIView
	
}

/*
public struct DeepParser: Parse {
    
    var tagStart: Character = "["
    var tagEnd: Character = "]"
    var tagParameter: Character = "="
    var tagClose: Character = "/"
    
    public func parse(_ input: String) -> TreeToken {
        var output1: TreeToken!
        
		/*
        var output = [Token]()
        var activeTags = [Tag]()
        var content: String = ""
        
        
        var tagIdentifier = ""
        var tag_Parameter: String?
        var tagInside = false
        var tag_Close = false
		*/
        
        var index = 0
        while index < input.count {
            let char = input[index] as Character
            
            
            switch char {
                case tagStart:
					continue
					/*
                    if !content.isEmpty {
                        output += [Token(text: content, tags: activeTags)]
                        content = ""
                    }
                    tagInside = true
					*/
				
                case tagEnd:
					continue
					/*
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
					*/
                    
					/*
                    tagIdentifier = ""
                    tagParameter = nil
                    tagClose = false
                    tagInside = false
					*/
                case tagClose:
					continue
					/*
                    if !tagIdentifier.isEmpty {
                        let tag = Tag(type: tagIdentifier, parameter: tagParameter)
                        activeTags.append(tag)
                        output += [Token(text: "", tags: activeTags)]
                    }
                    tagClose = true
					*/
                case tagParameter:
					continue
					/*
                    index += 1
                    tagParameter = input.dropFirst(index).prefix { !($0.isWhitespace || $0 == FlatParser.TAG_END) }.string
                    index += tagParameter!.count
                    continue
					*/
                default:
					continue
					/*
                    if tagInside {
                        if !char.isWhitespace {
                            tagIdentifier += char.string
                        }
                    } else {
                        content += char.string
                    }
					*/
            }
            
            index += 1
        }
        
		/*
        if !content.isEmpty {
            output += [Token(text: content, tags: .init())]
        }
		*/
        
        return output1
    }
    
}
*/
