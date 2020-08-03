//
//  Token.swift
//  RTFView
//
//  Created by Marco Seidel on 30.03.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation

public struct Token: Equatable {
	public let text: String
	public let tags: [Tag]
    
    public init(text: String, tags: [Tag]) {
        self.text = text
        self.tags = tags
    }
    
}
