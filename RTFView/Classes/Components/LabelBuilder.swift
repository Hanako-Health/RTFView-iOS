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
	let color: UIColor
	let size: CGFloat
	let indent: CGFloat
	
	public init(color: UIColor, size: CGFloat, indent: CGFloat) {
		self.color = color
		self.size = size
		self.indent = indent
 	}
	
	public func build(for tokens: [Token]) -> UIView {
		let label = UILabel()
		label.numberOfLines = 0
		label.attributedText = buildAttributedString(for: tokens)
		return label
	}
	
	private func buildAttributedString(for tokens: [Token]) -> NSMutableAttributedString {
		let completeText = tokens.map { $0.text }.joined()
		let result = NSMutableAttributedString(string: completeText, attributes: nil)
		
		var index = 0
		for token in tokens {
			let range = index..<(index + token.text.count)
			let attrs = buildAttributes(for: Array(token.tags))
			result.addAttributes(attrs, range: NSRange(range))
			index += token.text.count
		}
	
		return result
	}
	
	private func buildAttributes(for tags: [Tag]) -> [NSAttributedString.Key:Any] {
		let contains: (String) -> Bool = tags.map { $0.type }.contains
		var attributes = [NSAttributedString.Key:Any]()
		let paragraph = NSMutableParagraphStyle()
		var font = UIFont.systemFont(ofSize: size)
		
		paragraph.addTabStop(NSTextTab(textAlignment: .left, location: indent, options: [:]))
		paragraph.defaultTabInterval = indent
		paragraph.headIndent = indent
		paragraph.lineBreakMode = .byWordWrapping
		
		
		if contains("U") { attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue }
		if contains("B") { font = font.add(trait: .traitBold) }
		if contains("I") { font = font.add(trait: .traitItalic) }
		
		attributes[NSAttributedString.Key.font] = font
		attributes[NSAttributedString.Key.foregroundColor] = color
		attributes[NSAttributedString.Key.paragraphStyle] = paragraph
		
		
		return attributes
	}
	
	
}
