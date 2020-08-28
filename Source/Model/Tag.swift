//
//  Tag.swift
//  RTFView
//
//  Created by Marco Seidel on 30.03.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation

public struct Tag: Hashable {
	
	public let type: String
	public let parameter: String?
    
    public init(
		type: String,
		parameter: String? = nil
	) {
        self.type = type
        self.parameter = parameter
    }
    
}
