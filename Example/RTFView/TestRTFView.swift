//
//  TestRTFView.swift
//  RTFView_Example
//
//  Created by Marco Seidel on 23.04.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import RTFView

class TestRTFView: RTFView, RTFDelegate, SpaceDelegate {
	
	// Constants
	
	private let sizeDef: CGFloat = UIFont.systemFontSize
	private let sizeTitle: CGFloat = 16.0
	private let radius: CGFloat = 8.0
	private let cardInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
	
	// Components
	
    private lazy var labelDef = LabelBuilder(delegate: self)
	private lazy var labelList = LabelBuilder(delegate: self, indent: 20)
    
	private lazy var label = IndentWrapper(
		wrapped: labelDef,
		insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
	)
	private lazy var bullet = CardWrapper(
		wrapped: IndentWrapper(
			wrapped: BulletBuilder(
				label: labelList
			),
			insets: cardInset
		),
		color: UIColor.gray,
		radius: radius
	)
	private lazy var enumeration = CardWrapper(
		wrapped: IndentWrapper(
			wrapped: EnumerationBuilder(
				label: labelList
			),
			insets: cardInset
		),
		color: UIColor.gray,
		radius: radius
	)
	private lazy var card = CardWrapper(
		wrapped: IndentWrapper(
			wrapped: labelDef,
			insets: cardInset
		),
		color: UIColor.gray,
		radius: radius
	)
	private lazy var image = ListLayoutWrapper(
		wrapped: CardWrapper(
			wrapped: ImageBuilder(delegate: self),
			color: .red,
			radius: radius
		)
	)
	private lazy var buttonLink = createButton(image: UIImage(systemName: "link")!)
	private lazy var buttonMail = createButton(image: UIImage(systemName: "envelope.fill")!)
	private lazy var buttonPhone = createButton(image: UIImage(systemName: "phone.fill")!)
	
	// Setup
	
	private lazy var mapping = [
		nil : label,
		"S1" : label,
		"S2" : bullet,
		"S3" : enumeration,
		"S4" : card,
		"SP" : SpaceBuilder(delegate: self),
		"L1" : buttonLink,
		"L2" : buttonMail,
		"L3" : buttonPhone,
		"IMG" : image
	]
	private lazy var selection = SelectionBuilder(mapping: mapping, delegate: self)
	private lazy var segment = SegmentBuilder(wrapped: selection, delegate: self)
	private lazy var layout = ListLayoutWrapper(wrapped: segment)
    private lazy var spaceConfig = SpaceConfigWrapper(wrapped: layout, delegate: self)
    override var root: RTFBuild { spaceConfig }
    override var parser: RTFParser { FlatParser() }
    
	// Delegate
	
	func type(for token: Token) -> String? {
		getMainTag(for: token)?.type
	}
	
	func parameter(for token: Token) -> String? {
		getMainTag(for: token)?.parameter
	}
	
	func event(for token: Token, in view: UIView) {
        if let label = view as? UILabel {
            let size = token.contains(type: "S1") ? sizeTitle : sizeDef
            let color: UIColor = token.contains(any: "L1", "L2", "L3") ? .blue : .lightGray
            
            label.font = .systemFont(ofSize: size)
            label.textColor = color
        } else if let image = view as? UIImageView {
            print("Load \(parameter(for: token) ?? "??") into view: \(image)")
        }
	}
    
    private let spaceHalf: CGFloat = 8
    private let spaceDefault: CGFloat = 16
    private let spaceDouble: CGFloat = 32
	
    func space(from token0: Token, to token1: Token) -> CGFloat? {
        let type0 = type(for: token0)
        let type1 = type(for: token1)
        
        guard type0 != type1 else { return nil }
        guard type0 != "SP", type1 != "SP" else { return nil }
        
        if type1 == "S1" {
            return spaceDouble
        }
        
        let halfSpaceTokens = ["S2", "S3", "S4", "L1", "L2", "L3"]
        if token0.contains(any: halfSpaceTokens), token1.contains(any: halfSpaceTokens) {
            return spaceHalf
        }
        
        return spaceDefault
    }
    
	// Helper
	
	private func getMainTag(for token: Token) -> Tag? {
		let types = ["S1", "S2", "S3", "S4", "L1", "L2", "L3", "SP", "P", "IMG"]
		return token.tags.first { types.contains($0.type) }
	}
	
	private func createButton(image: UIImage) -> RTFBuild {
		CardWrapper(
			wrapped: IndentWrapper(
				wrapped: ButtonBuilder(
					delegate: self,
					label: label,
					image: image
				),
				insets: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
			),
			color: UIColor.gray,
			radius: radius
		)
	}
	
}
