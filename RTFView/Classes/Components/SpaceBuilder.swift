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
	weak var delegate: RTFDelegate?
	
	public init(delegate: RTFDelegate) {
		self.delegate = delegate
	}
	
	public func build(for tokens: [Token]) -> UIView {
		guard
			let first = tokens.first,
			let delegate = delegate,
			let param = delegate.parameter(for: first),
			let space = NumberFormatter().number(from: param)
			else { return UIView() }
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.heightAnchor.constraint(equalToConstant: CGFloat(truncating: space))
		])
		return view
	}

}
