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

class TestRTFView: RTFView, RTFTypeSelector, RTFParameterSelector, RTFLinkOpen {
	
	private let defaultFontColor = UIColor(hexString: "585f66")
	private let linkFontColor = UIColor(hexString: "0796ee")
	private let cardColor = UIColor(hexString: "f2f5f8")
	
	private let defaultFontSize: CGFloat = UIFont.systemFontSize
	private let titleFontSize: CGFloat = 16.0
	private let radius: CGFloat = 8.0
	private let cardInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
	private let linkImage = UIImage(systemName: "link")!
	private let mailImage = UIImage(systemName: "envelope.fill")!
	private let mobileImage = UIImage(systemName: "phone.fill")!
	
	init() {
		super.init(frame: .zero)
		
		let mapping: [String?:RTFBuild] = [
			nil : createDefaultLabel(),
			"S1" : createTitle(),
			"S2" : createBullet(),
			"S3" : createEnumeration(),
			"S4" : createCard(),
			"SP" : SpaceBuilder(space: 8),
			"L0" : createLinkButton(image: linkImage),
			"L1" : createLinkButton(image: mailImage),
			"L2" : createLinkButton(image: mobileImage)
		]
		
		let selection = SelectionBuilder(mapping: mapping, selector: self)
		let segment = SegmentBuilder(wrapped: selection, selector: self)
		rootBuild = ListLayoutWrapper(wrapped: segment, spacing: 8)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func card(around build: RTFBuild) -> RTFBuild {
		CardWrapper(
			wrapped: build,
			color: cardColor,
			radius: radius
		)
	}
	
	private func button(label: RTFBuild, image: UIImage) -> RTFBuild {
		card(around: ButtonBuilder(
			open: self,
			selector: self,
			label: label,
			image: image
		))
	}
	
	private func getMainTag(for token: Token) -> Tag? {
		let types = ["S1", "S2", "S3", "S4", "L0", "L1", "L2", "SP"]
		return token.tags.first { types.contains($0.type) }
	}
	
	func getType(for token: Token) -> String? {
		getMainTag(for: token)?.type
	}
	
	func getParameter(for token: Token) -> String? {
		getMainTag(for: token)?.parameter
	}
	
	func open(for link: String) {
		print("OPEN: \(link)")
	}
	
	private func createCard() -> RTFBuild {
		CardWrapper(
			wrapped: IndentWrapper(
				wrapped: createDefaultLabel(),
				insets: cardInset
			),
			color: cardColor,
			radius: radius
		)
	}
	
	private func createBullet() -> RTFBuild {
		CardWrapper(
			wrapped: IndentWrapper(
				wrapped: BulletBuilder(
					label: createListLabel()
				),
				insets: cardInset
			),
			color: cardColor,
			radius: radius
		)
	}
	
	private func createEnumeration() -> RTFBuild {
		CardWrapper(
			wrapped: IndentWrapper(
				wrapped: EnumerationBuilder(
					label: createListLabel()
				),
				insets: cardInset
			),
			color: cardColor,
			radius: radius
		)
	}
	
	
	private func createLinkButton(image: UIImage) -> RTFBuild {
		CardWrapper(
			wrapped: IndentWrapper(
				wrapped: ButtonBuilder(
					open: self,
					selector: self,
					label: createLinkLabel(),
					image: image
				),
				insets: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
			),
			color: cardColor,
			radius: radius
		)
	}
	
	private func createTitle() -> RTFBuild {
		IndentWrapper(
			wrapped: createTitleLabel(),
			insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
		)
	}
	
	private func createListLabel() -> RTFBuild {
		LabelBuilder(color: defaultFontColor, size: defaultFontSize, indent: 20)
	}
	
	
	private func createDefaultLabel() -> RTFBuild {
		LabelBuilder(color: defaultFontColor, size: defaultFontSize, indent: 0)
	}
	
	private func createTitleLabel() -> RTFBuild {
		LabelBuilder(color: defaultFontColor, size: titleFontSize, indent: 0)
	}
	
	private func createLinkLabel() -> RTFBuild {
		LabelBuilder(color: linkFontColor, size: defaultFontSize, indent: 0)
	}
	
}
