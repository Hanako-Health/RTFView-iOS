//
//  SimpleRTFView.swift
//  RTFView
//
//  Created by Marco Seidel on 07.05.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

public class SimpleRTFView: RTFView {
    
    public override var root: Component { LabelBuilder(delegate: nil) }
    
    public override var parser: Parser { SimpleParser() }
    
}
