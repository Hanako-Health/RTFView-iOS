//
//  LayoutWrapper.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct ListLayoutWrapper: RTFBuild {
	let wrapped: RTFBuild
	
	public init(wrapped: RTFBuild) {
		self.wrapped = wrapped
	}
	
	public func build(for tokens: [Token]) -> UIView {
		let view = wrapped.build(for: tokens)
		for (i, v) in view.subviews.enumerated() {
			v.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				v.leftAnchor.constraint(equalTo: view.leftAnchor),
				v.rightAnchor.constraint(equalTo: view.rightAnchor),
			])
			
			if i == 0 {
				NSLayoutConstraint.activate([
					v.topAnchor.constraint(equalTo: view.topAnchor)
				])
			} else {
				NSLayoutConstraint.activate([
					v.topAnchor.constraint(equalTo: view.subviews[i - 1].bottomAnchor)
				])
			}
			
			if i == view.subviews.count - 1 {
				NSLayoutConstraint.activate([
					v.bottomAnchor.constraint(equalTo: view.bottomAnchor)
				])
			}
		}
		return view
	}
	
}
