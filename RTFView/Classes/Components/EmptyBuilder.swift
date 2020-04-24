//
//  EmptyBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct EmptyBuilder: RTFBuild {
	
	public init() {}
	
	public func build(for tokens: [Token]) -> UIView {
		UIView()
	}

}
