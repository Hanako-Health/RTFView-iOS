//
//  SanitizeWrapper.swift
//  RTFView
//
//  Created by Marco Seidel on 20.05.20.
//

import Foundation

public struct SanitizeWrapper: RTFBuild {
    private let wrapped: RTFBuild
    
    public init(wrapped: RTFBuild) {
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
