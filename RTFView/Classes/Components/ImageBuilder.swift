//
//  ImageBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct ImageBuilder: RTFBuild {
	weak var delegate: RTFDelegate?
	
	public init(
		delegate: RTFDelegate?
	) {
		self.delegate = delegate
	}
	
	public func build(for tokens: [Token]) -> UIView {
		let container = UIView()
		tokens.map {
			let view = UIImageView()
			view.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9.0 / 16.0)
			])
			delegate?.event(for: $0, in: view)
			return view
		}.forEach {
			container.addSubview($0)
		}
		return container
	}
	
}
