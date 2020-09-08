//
//  SegmentBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation
import UIKit

public struct SegmentBuilder: Component {
	let wrapped: Component
	weak var delegate: RTFDelegate?
	
	public init(wrapped: Component, delegate: RTFDelegate?) {
		self.wrapped = wrapped
		self.delegate = delegate
	}
	
	public func build(for tokens: [Token]) -> UIView {
		guard let delegate = delegate, !tokens.isEmpty else { return UIView() }
        
        var output: [[Token]] = [[tokens.first!]]
                
        tokens.enumerated().dropFirst().forEach { (i, t) in
            let lastType = delegate.type(for: tokens[i - 1])
            let type = delegate.type(for: t)
            let lastParameter = delegate.parameter(for: tokens[i - 1])
            let parameter = delegate.parameter(for: t)
            
            if lastType == type && lastParameter == parameter {
                output[output.count - 1] = output.last! + [t]
            } else {
                output.append([t])
            }
        }

        let container = UIView()
        output.map { segment in
            wrapped.build(for: segment)
        }.forEach { view in
            container.addSubview(view)
        }
        
        return container
	}
	
	
}
