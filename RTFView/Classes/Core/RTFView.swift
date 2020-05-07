//
//  RTFView.swift
//  RTFView
//
//  Created by Marco Seidel on 14.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

open class RTFView: UIView {
    
	open var root: RTFBuild { EmptyBuilder() }
	open var parser: RTFParser { EmptyParser() }
	
	public var text: String = "" {
		didSet {
			self.clearView()
            self.build(for: self.text)
		}
	}
	
	private func clearView() {
		subviews.forEach { $0.removeFromSuperview() }
	}
	
	private func build(for input: String) {
		let parsed = parser.parse(input: text)
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
