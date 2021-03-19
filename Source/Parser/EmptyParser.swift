//
//  EmptyParser.swift
//  RTFView
//
//  Created by Marco Seidel on 07.05.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

struct EmptyParser: Parser {
	
	var characters: Characters = .init()
    
    func parse(input: String) -> [Token] { [] }
    
}
