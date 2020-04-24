//
//  RTFImageLoad.swift
//  RTFView
//
//  Created by Marco Seidel on 21.04.20.
//  Copyright © 2020 Envidual. All rights reserved.
//

import Foundation
import UIKit

public protocol RTFImageLoad: AnyObject {
	
	func load(for image: String, into imageView: UIImageView)
	
}
