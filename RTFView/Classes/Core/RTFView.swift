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
	
	public lazy var rootBuild: RTFBuild = EmptyBuilder()
	public lazy var parser: RTFParser = Parser()
	
	public var text: String = "" {
		didSet {
			DispatchQueue.main.async {
				self.clearView()
				self.build(for: self.text)
				self.setNeedsLayout()
			}
		}
	}
	
	private func clearView() {
		subviews.forEach { $0.removeFromSuperview() }
	}
	
	
	private func build(for input: String) {
		let parsed = parser.parse(input: text)
		let build = rootBuild.build(for: parsed)
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

extension UIFont {
	
	func add(trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
		let traits = UIFontDescriptor.SymbolicTraits(arrayLiteral: fontDescriptor.symbolicTraits, trait)
		let descriptor = fontDescriptor.withSymbolicTraits(traits)!
		return UIFont(descriptor: descriptor, size: pointSize)
	}
	
}
