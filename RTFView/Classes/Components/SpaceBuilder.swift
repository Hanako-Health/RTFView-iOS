//
//  SpaceBuilder.swift
//  RTFView
//
//  Created by Marco Seidel on 22.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public struct SpaceBuilder: RTFBuild {
	private weak var delegate: RTFDelegate?
    private let `default`: CGFloat
    public init(delegate: RTFDelegate, default: CGFloat = 0) {
		self.delegate = delegate
        self.default = `default`
	}
	
	public func build(for tokens: [Token]) -> UIView {
        let formatter = NumberFormatter()
        let space = tokens.map { t -> CGFloat in
            guard
                let parameter = delegate?.parameter(for: t),
                let number = formatter.number(from: parameter)
                else { return `default` }
            return CGFloat(truncating: number)
        }.reduce(0, +)
        
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			view.heightAnchor.constraint(equalToConstant: space)
		])
		return view
	}

}
