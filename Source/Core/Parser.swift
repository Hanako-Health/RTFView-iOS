//
//  RTFParser.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

public protocol Parser {
	
	var characters: Characters { get set }
	
	func parse(input: String) -> [Token]
	
}
