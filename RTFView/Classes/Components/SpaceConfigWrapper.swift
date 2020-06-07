//
//  SpaceConfigWrapper.swift
//  Pods-RTFView_Example
//
//  Created by Marco Seidel on 19.05.20.
//

import Foundation


/**
    Asks delegate for spacing value between two tokens.
    Needs children of view built by `wrapped` to be constrained.
 */
public struct SpaceConfigWrapper: RTFBuild {
    private let wrapped: RTFBuild
    private weak var delegate: SpaceDelegate?
    
    public init(wrapped: RTFBuild, delegate: SpaceDelegate) {
        self.wrapped = wrapped
        self.delegate = delegate
    }
    
    public func build(for tokens: [Token]) -> UIView {
        let view = wrapped.build(for: tokens)
    
        guard let delegate = delegate, tokens.count > 1 else { return view }
        
        for i in 1..<tokens.count {
            guard let space = delegate.space(from: tokens[i - 1], to: tokens[i]) else { continue }
            let last = view.subviews[i - 1]
            let current = view.subviews[i]
            
            view.constraints.first {
                guard let f = $0.firstItem as? UIView, let s = $0.secondItem as? UIView else { return false }
                return (f == last && s == current) || (f == current && s == last)
            }?.constant = space
        }
        
        return view
    }
    

}
