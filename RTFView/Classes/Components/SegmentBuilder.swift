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
	weak var delegate: RTFDelegate?
	
	public init(wrapped: RTFBuild, delegate: RTFDelegate?) {
		self.wrapped = wrapped
		self.delegate = delegate
	}
	
	public func build(for tokens: [Token]) -> UIView {
		guard let delegate = delegate else { return UIView() }
		let container = UIView()
		tokens.reduce([[Token]]()) { result, token in
			let type = delegate.type(for: token)
			
			var result = result
			
			if result.isEmpty || type != delegate.type(for: result.last!.first!) {
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
