//
//  SegmentBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct SegmentBuilder: RTFBuild {
	let wrapped: RTFBuild
	weak var selector: RTFTypeSelector?
	
	public init(wrapped: RTFBuild, selector: RTFTypeSelector?) {
		self.wrapped = wrapped
		self.selector = selector
	}
	
	public func build(for tokens: [Token]) -> UIView {
		guard let selector = self.selector else { return UIView() }
		let container = UIView()
		tokens.reduce([[Token]]()) { result, token in
			let type = selector.getType(for: token)
			
			var result = result
			
			if result.isEmpty || type != selector.getType(for: result.last!.first!) {
				result.append([token])
			} else {
				result[result.count - 1] = result.last! + [token]
			}
			
			return result
		}.map { tokens in
			wrapped.build(for: tokens)
		}.forEach { view in
			container.addSubview(view)
		}
		
		return container
	}
	
	
}
