//
//  EmptyBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation
import UIKit

public struct EmptyComponent: Component {
	
	public init() {}
	
	public func build(for tokens: [Token]) -> UIView {
		UIView()
	}

}
