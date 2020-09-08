//
//  RTFTokenSelector.swift
//  RTFView
//
//  Created by Marco Seidel on 28.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

public protocol RTFDelegate: AnyObject {
	
	func type(for token: Token) -> String?
	
	func parameter(for token: Token) -> String?
	
	func event(for token: Token, in view: UIView)
	 
}
