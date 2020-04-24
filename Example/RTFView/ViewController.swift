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

	let testString = ""
		+ "[S1]Aufzählung[/S1]"
		+ "[S2]Listeneintrag 1\nListeneintrag 2, der alles in allem deutlich länger ist als Listeneintrag 1[/S2]"
		+ "[SP]_[/SP]"
		+ "[S1]Nummerierung[/S1]"
		+ "[S3]Listeneintrag 1\nListeneintrag 2, der alles in allem deutlich länger ist als Listeneintrag 1[/S3]"
		+ "[SP]_[/SP]"
		+ "[S1]Grau hinterlegter Text[/S1]"
		+ "[S4]Das ist der erste Satz.\n\nDas ist der zweite Satz, der alles in allem deutlich länger ist als der erste.[/S4]"
		+ "[SP]_[/SP]"
		+ "[S1]Externer Link[/S1]"
		+ "[L0=https://www.envidual.com]Link nach draußen[/L0]"
		+ "[L1=marco.seidel@envidual.com]Mail nach draußen[/L1]"
		+ "[L2=+0123456789]Anruf nach draußen[/L2]"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Setup view
		let rtfView = TestRTFView()
		view.addSubview(rtfView)
		rtfView.snp.makeConstraints {
			$0.left.right.top.equalToSuperview()
		}
		
		// Trigger parsing and view building
		rtfView.text = testString
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory? Never heard of that...")
    }

}

