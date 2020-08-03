//
//  BidirectionalCollection+Extension.swift
//  RTFView
//
//  Created by Marco Seidel on 30.03.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation

extension BidirectionalCollection {
	subscript(safe offset: Int) -> Element? {
		guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
		return self[i]
	}
}
