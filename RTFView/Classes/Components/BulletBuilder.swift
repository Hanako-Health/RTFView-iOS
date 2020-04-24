//
//  BulletBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct BulletBuilder: RTFBuild {
	let label: RTFBuild
	
	public init(label: RTFBuild) {
		self.label = label
	}
	
	public func build(for tokens: [Token]) -> UIView {
		let tokens: [Token] = split(tokens: tokens).flatMap { ts -> [Token] in
			let bullet = Token(text: "\u{2219}\t", tags: [])
			let newLine = Token(text: "\n\n", tags: [])
			return [bullet] + ts + [newLine]
		}.dropLast()
		return label.build(for: tokens)
	}
	
	private func split(tokens: [Token]) -> [[Token]] {
		tokens.reduce([[Token]]([[]])) { output, token in
			var output = output
			let parts = token.text
				.split { $0.isNewline }
				.map { Token(text: $0.string, tags: token.tags) }
			
			output[output.count - 1] = output.last! + [parts.first!]
			output += parts.dropFirst().map { [$0] }
			return output
		}
	}
	
}
