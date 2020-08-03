//
//  TapRecognizer.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

class TapRecognizer: UITapGestureRecognizer {
	private let closure: () -> Void
	
	init(_ closure: @escaping () -> Void) {
		self.closure = closure
		super.init(target: nil, action: nil)
		self.addTarget(self, action: #selector(onTap))
	}
	
	@objc
	private func onTap() {
		closure()
	}
	
}
