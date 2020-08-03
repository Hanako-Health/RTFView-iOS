//
//  SpaceConfigWrapper.swift
//  Pods-RTFView_Example
//
//  Created by Marco Seidel on 19.05.20.
//

import Foundation

public struct SpaceConfigWrapper: Component {
    private let wrapped: Component
    private weak var delegate: SpaceDelegate?
    
    public init(wrapped: Component, delegate: SpaceDelegate) {
        self.wrapped = wrapped
        self.delegate = delegate
    }
    
    public func build(for tokens: [Token]) -> UIView {
        guard let delegate = delegate else { return wrapped.build(for: tokens) }
        
        var output = [Token]()
        for i in 0..<(tokens.count - 1) {
            
            if let spaceValue = delegate.space(from: tokens[i], to: tokens[i + 1]) {
                let spaceToken = Token(text: "", tags: [Tag(type: "SP", parameter: "\(spaceValue)")])
                output += [tokens[i], spaceToken]
            } else {
                output += [tokens[i]]
            }
        }
        output += [tokens.last!]
        return wrapped.build(for: output)
    }
    
}
