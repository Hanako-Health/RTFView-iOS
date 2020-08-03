//
//  SimpleRTFView.swift
//  Pods-RTFView_Example
//
//  Created by Marco Seidel on 07.05.20.
//

import Foundation

public class SimpleRTFView: RTFView {
    
    public override var root: Component { LabelBuilder(delegate: nil) }
    
    public override var parser: Parser { SimpleParser() }
    
}
