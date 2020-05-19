//
//  SpaceProvider.swift
//  Pods-RTFView_Example
//
//  Created by Marco Seidel on 19.05.20.
//

import Foundation

public protocol SpaceDelegate: AnyObject {
    
    func space(from token0: Token, to token1: Token) -> CGFloat?
    
}
