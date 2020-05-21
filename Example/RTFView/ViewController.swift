//
//  ViewController.swift
//  RTFView
//
//  Created by Marco Seidel on 04/22/2020.
//  Copyright (c) 2020 Marco Seidel. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Setup view
		
        let scroll = UIScrollView()
        let rtfView = TestRTFView()
		scroll.addSubview(rtfView)
        view.addSubview(scroll)
        
        
        
		scroll.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        rtfView.snp.makeConstraints {
            $0.top.equalTo(44)
            $0.bottom.equalTo(-34)
            $0.left.equalTo(8)
            $0.right.equalTo(-8)
            $0.width.equalTo(UIScreen.main.bounds.width - 16)
        }
		
		rtfView.text = """
        [S2]
        First
        Second
        Third
        [/S2]
        """
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory? Never heard of that...")
    }
    
}

