//
//  RTFLinkOpen.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation

public protocol RTFLinkOpen: AnyObject {
	
	func open(for link: String)
	
}
