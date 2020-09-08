//
//  CardWrapper.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation
import UIKit

public struct CardWrapper: Component {
	let wrapped: Component
	let color: UIColor
	let radius: CGFloat
	
	public init(wrapped: Component, color: UIColor, radius: CGFloat) {
		self.wrapped = wrapped
		self.color = color
		self.radius = radius
	}

	public func build(for tokens: [Token]) -> UIView {
		let content = wrapped.build(for: tokens)
		content.layer.cornerRadius = radius
		content.backgroundColor = color
		content.clipsToBounds = true
		return content
	}
	
}
