//
//  SanitizeWrapper.swift
//  RTFView
//
//  Created by Marco Seidel on 20.05.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

public struct SanitizeWrapper: Component {
    private let wrapped: Component
    
    public init(wrapped: Component) {
        self.wrapped = wrapped
    }
    
    public func build(for tokens: [Token]) -> UIView {
        wrapped.build(for: tokens.map {
            Token(
                text: $0.text.replacingOccurrences(of: #"\n\r|\r\n"#, with: "\n"),
                tags: $0.tags
            )
        })
    }
    
}
