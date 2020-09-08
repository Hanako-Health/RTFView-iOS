//
//  TokenUtil+Extension.swift
//  RTFView
//
//  Created by Marco Seidel on 28.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

extension TokenUtil {
	
	static func split(tokens: [Token], by char: Character) -> [[Token]] {
		split(tokens: tokens, by: { $0 == char })
	}
	
	static func splitByLine(tokens: [Token]) -> [[Token]] {
		split(tokens: tokens, by: { $0.isNewline })
	}
	
}
