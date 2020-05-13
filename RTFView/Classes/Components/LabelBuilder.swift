//
//  LabelBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct LabelBuilder: RTFBuild {
	weak var delegate: RTFDelegate?
    let indent: CGFloat
    
    public init(delegate: RTFDelegate?, indent: CGFloat = 0) {
		self.delegate = delegate
        self.indent = indent
    }
	
	public func build(for tokens: [Token]) -> UIView {
        guard !tokens.isEmpty else { return UIView() }
        
        let text = tokens.map { $0.text }.joined()
        let range = NSRange(0..<text.count)
        
        let label = UILabel()
        label.text = text
		label.numberOfLines = 0
        delegate?.event(for: tokens.first!, in: label)
        
        let string: NSMutableAttributedString = label.attributedText == nil
            ? .init()
            : .init(attributedString: label.attributedText!)
                
        let font = label.font
            ?? (string.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil) as? UIFont)
            ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
                
        let color = label.textColor
            ?? (string.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor)
            ?? UIColor.black
        
        let paragraph = string.attribute(NSAttributedString.Key.font, at: 0, effectiveRange: nil)
            as? NSMutableParagraphStyle
            ?? NSMutableParagraphStyle()
        paragraph.addTabStop(NSTextTab(textAlignment: .left, location: indent, options: [:]))
        paragraph.defaultTabInterval = indent
        paragraph.headIndent = indent
        paragraph.lineBreakMode = .byWordWrapping
    
        if let paragraphStyle = string.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
            paragraph.lineSpacing = paragraphStyle.lineSpacing
            paragraph.lineHeightMultiple = paragraphStyle.lineHeightMultiple
            paragraph.paragraphSpacing = paragraphStyle.paragraphSpacing
            paragraph.alignment = paragraphStyle.alignment
        }
        
        let kerning = string.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: nil) as? CGFloat?
        
        var index = 0
        for token in tokens {
            let tokenRange = NSRange(index..<(index + token.text.count))
            
            
            if token.contains(type: "U") {
                string.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: tokenRange)
            }
            
            var tokenFont = font.copyFont()
            
            
            if token.contains(type: "I") {
                tokenFont = tokenFont.add(trait: .traitItalic)
            }
            
            if token.contains(type: "B") {
                tokenFont = tokenFont.add(trait: .traitBold)
            }
            
            string.addAttribute(.font, value: tokenFont, range: tokenRange)
            string.addAttribute(.paragraphStyle, value: paragraph, range: tokenRange)
            if let kerning = kerning {
                string.addAttribute(.kern, value: kerning as Any, range: tokenRange)
            }
            
            index += token.text.count
        }
        
        string.addAttribute(.foregroundColor, value: color, range: range)
        
        label.attributedText = string
        
		return label
	}
	
}
