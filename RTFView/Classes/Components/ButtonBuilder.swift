//
//  ButtonBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct ButtonBuilder: RTFBuild {
	weak var open: RTFLinkOpen?
	weak var selector: RTFParameterSelector?
	
	let label: RTFBuild
	let image: UIImage
	
	public init(open: RTFLinkOpen?, selector: RTFParameterSelector?, label: RTFBuild, image: UIImage) {
		self.open = open
		self.selector = selector
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
				let selector = self.selector,
				let open = self.open,
				let first = tokens.first,
				let parameter = selector.getParameter(for: first)
				else { return }
			open.open(for: parameter)
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


