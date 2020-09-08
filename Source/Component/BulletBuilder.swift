//
//  BulletBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation
import UIKit

public struct BulletBuilder: Component {
	let label: Component
	
	public init(label: Component) {
		self.label = label
	}
	
	public func build(for tokens: [Token]) -> UIView {
		let tokens: [Token] = TokenUtil.splitByLine(tokens: tokens).flatMap { ts -> [Token] in
            let bullet = Token(text: "\u{25CF}\t", tags: [])
			let newLine = Token(text: "", tags: [Tag(type: "SP", parameter: nil)])
			return [bullet] + ts + [newLine]
		}.dropLast()
		return label.build(for: tokens)
	}
	
}
