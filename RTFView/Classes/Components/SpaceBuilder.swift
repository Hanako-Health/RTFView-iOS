//
//  SpaceBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 22.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct SpaceBuilder: RTFBuild {
	let space: CGFloat
	
	public init(space: CGFloat) {
		self.space = space
	}
	
	public func build(for tokens: [Token]) -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.heightAnchor.constraint(equalToConstant: space)
		])
		return view
	}

}
