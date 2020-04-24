//
//  SelectionBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct SelectionBuilder: RTFBuild {
	let mapping: [String?:RTFBuild]
	weak var selector: RTFTypeSelector?
	
	public init(mapping: [String?:RTFBuild], selector: RTFTypeSelector?) {
		self.mapping = mapping
		self.selector = selector
	}
	
	public func build(for tokens: [Token]) -> UIView {
		guard
			let selector = self.selector,
			let first = tokens.first,
			let build = mapping[selector.getType(for: first)]
			else { return UIView() }
		return build.build(for: tokens)
	}
	
}
