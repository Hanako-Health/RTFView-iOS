//
//  IndentWrapper.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct IndentWrapper: RTFBuild {
	let wrapped: RTFBuild
	let insets: UIEdgeInsets
	
	public init(wrapped: RTFBuild, insets: UIEdgeInsets) {
		self.wrapped = wrapped
		self.insets = insets
	}
	
	public func build(for tokens: [Token]) -> UIView {
		let container = UIView()
		let content = wrapped.build(for: tokens)
		
		content.translatesAutoresizingMaskIntoConstraints = false
		
		container.addSubview(content)
		
		NSLayoutConstraint.activate([
			content.leftAnchor.constraint(equalTo: container.leftAnchor, constant: insets.left),
			content.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -insets.right),
			content.topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
			content.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -insets.bottom)
			
		])
		
		return container
	}
	
}
