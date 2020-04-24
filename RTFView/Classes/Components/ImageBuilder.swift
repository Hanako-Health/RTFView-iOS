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
	weak var loader: RTFImageLoad?
	let typeId: String
	
	public init(loader: RTFImageLoad?, typeId: String) {
		self.loader = loader
		self.typeId = typeId
	}
	
	public func build(for tokens: [Token]) -> UIView {
		let container = UIView()
		tokens.map {
			let view = UIImageView()
			view.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9.0 / 16.0)
			])
			if let image = $0.tags.first(where: { $0.type == typeId })?.parameter {
				loader?.load(for: image, into: view)
			}
			return view
		}.forEach {
			container.addSubview($0)
		}
		return container
	}
	
}
