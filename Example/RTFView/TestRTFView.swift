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

class TestRTFView: RTFView, RTFDelegate {
	
	// Constants
	
	private let sizeDef: CGFloat = UIFont.systemFontSize
	private let sizeTitle: CGFloat = 16.0
	private let radius: CGFloat = 8.0
	private let cardInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
	
	// Components
	
	private lazy var labelDef = LabelBuilder(color: UIColor.darkGray, size: sizeDef, indent: 0)
	private lazy var labelList = LabelBuilder(color: UIColor.darkGray, size: sizeDef, indent: 20)
	private lazy var labelLink = LabelBuilder(color: UIColor.blue, size: sizeDef, indent: 0)
	private lazy var labelTitle = LabelBuilder(color: UIColor.darkGray, size: sizeTitle, indent: 0)
	private lazy var header = IndentWrapper(
		wrapped: labelTitle,
		insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
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
		),
		spacing: 0
	)
	private lazy var buttonLink = createButton(image: UIImage(systemName: "link")!)
	private lazy var buttonMail = createButton(image: UIImage(systemName: "envelope.fill")!)
	private lazy var buttonPhone = createButton(image: UIImage(systemName: "phone.fill")!)
	
	// Setup
	
	private lazy var mapping = [
		nil : labelDef,
		"S1" : header,
		"S2" : bullet,
		"S3" : enumeration,
		"S4" : card,
		"SP" : SpaceBuilder(delegate: self),
		"L0" : buttonLink,
		"L1" : buttonMail,
		"L2" : buttonPhone,
		"IMG" : image
	]
	private lazy var selection = SelectionBuilder(mapping: mapping, delegate: self)
	private lazy var segment = SegmentBuilder(wrapped: selection, delegate: self)
	
	// Override
	
	init() {
		super.init(frame: .zero)
		rootBuild = ListLayoutWrapper(wrapped: segment, spacing: 8)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		rootBuild = ListLayoutWrapper(wrapped: segment, spacing: 8)
	}
	
	func type(for token: Token) -> String? {
		getMainTag(for: token)?.type
	}
	
	func parameter(for token: Token) -> String? {
		getMainTag(for: token)?.parameter
	}
	
	func event(for token: Token, in view: UIView) {
		print("Event:\n\t\(token)\n\t\(view)")
	}
	
	// Helper
	
	private func getMainTag(for token: Token) -> Tag? {
		let types = ["S1", "S2", "S3", "S4", "L0", "L1", "L2", "SP", "P", "IMG"]
		return token.tags.first { types.contains($0.type) }
	}
	
	private func createButton(image: UIImage) -> RTFBuild {
		CardWrapper(
			wrapped: IndentWrapper(
				wrapped: ButtonBuilder(
					delegate: self,
					label: labelLink,
					image: image
				),
				insets: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
			),
			color: UIColor.gray,
			radius: radius
		)
	}
	
}
