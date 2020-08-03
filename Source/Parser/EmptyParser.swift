//
//  EmptyParser.swift
//  Pods-RTFView_Example
//
//  Created by Marco Seidel on 07.05.20.
//

import Foundation

struct EmptyParser: Parser {
    
    func parse(input: String) -> [Token] { [] }
    
}
