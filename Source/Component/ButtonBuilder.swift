//
//  ButtonBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation
import UIKit

public struct ButtonBuilder: Component {
	weak var delegate: RTFDelegate?
	
	let label: Component
	let image: UIImage
	
	public init(
		delegate: RTFDelegate?,
		label: Component,
		image: UIImage
	) {
		self.delegate = delegate
		self.label = label
		self.image = image
	}
	
	
	public func build(for tokens: [Token]) -> UIView {
		let container = UIView()
		let labelView = label.build(for: tokens)
		let imageView = UIImageView(image: image)
		
		labelView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .center
		imageView.translatesAutoresizingMaskIntoConstraints = false
		container.addGestureRecognizer(TapRecognizer {
			guard
				let delegate = self.delegate,
				let first = tokens.first
				else { return }
			delegate.event(for: first, in: container)
		})
		
		container.addSubview(labelView)
		container.addSubview(imageView)
		
		container.addConstraints([
			labelView.topAnchor.constraint(equalTo: container.topAnchor),
			labelView.leftAnchor.constraint(equalTo: container.leftAnchor),
			labelView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
			labelView.rightAnchor.constraint(equalTo: imageView.leftAnchor, constant: -8),
			
			imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
			imageView.rightAnchor.constraint(equalTo: container.rightAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 24),
			imageView.widthAnchor.constraint(equalToConstant: 24),
			
			container.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
		])
		
		return container
	}
	
}


