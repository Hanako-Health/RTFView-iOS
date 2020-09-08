//
//  RTFBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 17.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation
import UIKit

public protocol Component {
	
	func build(for tokens: [Token]) -> UIView

}
