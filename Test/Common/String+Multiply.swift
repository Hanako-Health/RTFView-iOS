//
//  StringProtocol+Multiply.swift
//  RTFView
//
//  Created by Marco Seidel on 28.04.20.
//  Copyright © 2020 Hanako. All rights reserved.
//

import Foundation

func *(left: String, right: Int) -> String {
	var left = left
	for _ in 0..<right {
		left += left
	}
	return left
}

func *(left: Int, right: String) -> String {
	right * left
}
