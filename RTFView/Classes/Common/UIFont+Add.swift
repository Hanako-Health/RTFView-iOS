//
//  UIFont+Add.swift
//  Pods-RTFView_Example
//
//  Created by Marco Seidel on 07.05.20.
//

import Foundation
import UIKit

extension UIFont {
    
    func copyFont() -> UIFont {
        .init(descriptor: fontDescriptor, size: pointSize)
    }
    
    func add(trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let traits = UIFontDescriptor.SymbolicTraits(arrayLiteral: fontDescriptor.symbolicTraits, trait)
        let descriptor = fontDescriptor.withSymbolicTraits(traits)!
        return UIFont(descriptor: descriptor, size: pointSize)
    }
    
}
