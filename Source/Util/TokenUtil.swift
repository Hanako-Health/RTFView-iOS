//
//  TokenUtil.swift
//  RTFView
//
//  Created by Marco Seidel on 28.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

struct TokenUtil {
	private init() {}
	
	static func split(tokens: [Token], by closure: (Character) -> Bool) -> [[Token]] {
		var tokens = tokens.reduce([[Token]]([[]])) { output, token in
			var output = output
			
			guard !token.text.isEmpty else { return output }
			
			let parts = token.text
				.split(omittingEmptySubsequences: false, whereSeparator: closure)
			
			if let first = parts.first, !first.isEmpty {
				let t = Token(text: String(first), tags: token.tags)
				output[output.count - 1] = output.last! + [t]
			}
			
			output += parts.dropFirst()
				.filter { !$0.isEmpty }
				.map { [Token(text: String($0), tags: token.tags)] }
			
			if let last = parts.dropFirst().last, last.isEmpty {
				output += [[]]
			}
			
			return output
		}
		
		if tokens.first?.isEmpty == true {
			tokens = Array(tokens.dropFirst())
		}
		
		if tokens.last?.isEmpty == true {
			tokens = tokens.dropLast()
		}
		
		return tokens
	}
	
}
