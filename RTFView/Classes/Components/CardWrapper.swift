//
//  CardWrapper.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct CardWrapper: RTFBuild {
	let wrapped: RTFBuild
	let color: UIColor
	let radius: CGFloat
	
	public init(wrapped: RTFBuild, color: UIColor, radius: CGFloat) {
		self.wrapped = wrapped
		self.color = color
		self.radius = radius
	}

	public func build(for tokens: [Token]) -> UIView {
		let content = wrapped.build(for: tokens)
		content.layer.cornerRadius = radius
		content.backgroundColor = color
		return content
		/*let card = UIView()
		card.layer.cornerRadius = radius
		card.backgroundColor = color
		card.addSubview(content)
		NSLayoutConstraint.activate([
			content.leftAnchor.constraint(equalTo: card.leftAnchor),
			content.rightAnchor.constraint(equalTo: card.rightAnchor),
			content.topAnchor.constraint(equalTo: card.topAnchor),
			content.bottomAnchor.constraint(equalTo: card.bottomAnchor)
		])
		return card*/
	}
	
}
