//
//  RTFView.swift
//  RTFView
//
//  Created by Marco Seidel on 14.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation
import UIKit

open class RTFView: UIView {
    
	open var root: Component { EmptyComponent() }
	open var parser: Parser { EmptyParser() }
	
	public var text: String = "" {
		didSet {
			self.clearView()
			guard !text.isEmpty else { return }
            self.build(for: self.text)
		}
	}
	
	private func clearView() {
		subviews.forEach { $0.removeFromSuperview() }
	}
	
	private func build(for input: String) {
		let parsed = parser.parse(input: text)
		guard !parsed.isEmpty else { return }
		let build = root.build(for: parsed)
		build.translatesAutoresizingMaskIntoConstraints = false
		addSubview(build)
		addConstraints([
			build.leftAnchor.constraint(equalTo: leftAnchor),
			build.rightAnchor.constraint(equalTo: rightAnchor),
			build.topAnchor.constraint(equalTo: topAnchor),
			build.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
}
