//
//  Token+Contains.swift
//  Pods-RTFView_Example
//
//  Created by Marco Seidel on 07.05.20.
//

import Foundation

extension Token {
    
    public func contains(type: String) -> Bool {
        tags.map { $0.type }.contains(type)
    }
    
    public func contains(any: [String]) -> Bool {
        any.first { contains(type: $0) } != nil
    }
    
    public func contains(any: String...) -> Bool {
        contains(any: any)
    }
    
    public func contains(all: [String]) -> Bool {
        all.allSatisfy { contains(type: $0) }
    }
    
    public func contains(all: String...) -> Bool {
        contains(all: all)
    }
    
}
