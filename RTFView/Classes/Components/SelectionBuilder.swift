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
	weak var delegate: RTFDelegate?
	
	public init(mapping: [String?:RTFBuild], delegate: RTFDelegate?) {
		self.mapping = mapping
		self.delegate = delegate
	}
	
	public func build(for tokens: [Token]) -> UIView {
		guard
			let delegate = delegate,
			let first = tokens.first,
			let build = mapping[delegate.type(for: first)]
			else { return UIView() }
		return build.build(for: tokens)
	}
	
}
