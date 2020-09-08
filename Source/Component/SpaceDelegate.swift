//
//  SpaceProvider.swift
//  RTFView
//
//  Created by Marco Seidel on 19.05.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

public protocol SpaceDelegate: AnyObject {
    
    func space(from token0: Token, to token1: Token) -> CGFloat?
    
}
