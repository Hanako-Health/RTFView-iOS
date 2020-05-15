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
	
	let testString2 = "[S1]Titel: Beispiel[/S1][S3]\n\n\n\n\n\nNormal\n\n\n[B]Fett[/B]\n\n\n[I]Kursiv[/I]\n[U]Unterstrichen[/U]\n\n\n\n[/S3][IMG=BUNDLE /]"
	
    let testString3 = """
[S1]Test der Formatierungen[/S1]
​
[B]Dieser Satz ist fett.[/B]
[I]Dieser Satz ist kursiv.[/I]
[U]Dieser Satz ist unterstrichen.[/U]
​
Dieser Satz enthält [B]fette Worte[/B] und [I]kursive Worte[/I] und [U]unterstrichene Worte[/U] und endet in normaler Schrift. Die trennenden "und" sind nicht formatiert. [B][I][U]Dieser Satz schließt sich unmittelbar an und ist mit allen Formatierungsoptionen gleichzeitig formatiert.[/U][/I][/B]
​
[S1]Eine Zwischenüberschrift[/S1]
​
Eine Liste mit Punkten, wie alle Listen grau hinterlegt. Der zweite Eintrag ist fett, der dritte kursiv, der vierte unterstrichen:
​
[S2]Eins
[B]Zwei[/B]
[I]Drei[/I]
[U]Vier[/U][/S2]
​
Eine nummerierte Liste, wie alle Listen grau hinterlegt. Der erste Eintrag ist fett, der zweite kursiv, der dritte unterstrichen:
​
[S3][B]Eins[/B]
[I]Zwei[/I]
[U]Drei[/U]
Vier[/S3]
​
[S4]Ein Text in einem grauen [B]Kasten[/B], der ihn hervorhebt. Das Wort "Kasten" ist fett.[/S4]
​
Drei Linkelemente:
​
[L1=www.google.de]Externer Link zu Google mit Link-Symbol[/L1]
[L2=info@hanako-health.com]Info-Adresse von Hanako mit Mail-Symbol[/L2]
[L3=0898012345]Fiktive Telefonnummer mit Hörer-Symbol[/L3]
​
Ein Bild. Darunter ein Text in einem grauen Kasten. Der Kasten ist so breit wie das Bild:
​
[IMG=Service_Foto_Reise /]
[S4][U]Dieser Text wird in einem grauen Kasten angezeigt und ist unterstrichen.[/U][/S4]
​
[S1]Test der Abstände[/S1]
​
Vor der Zwischenüberschrift oben: Abstand A2. Darunter: Abstand A1 (Leerzeilen werden ignoriert).
​
Zeile 1
Zeile 2
​
Vor Zeile 1: Abstand A1. Zwischen Zeile 1 und Zeile 2: Abstand A0. Nach Zeile 2: Abstand A1 (Leerzeilen werden nicht ignoriert).
​
[S2]Punkt 1
Punkt 2[/S2]
[S3]Nummer 1
Nummer 2[/S3]
[S4]Hervorgehoben[/S4]
[L1=www.google.de]Link[/L1]
[L2=info@hanako-health.com]Mail[/L2]
[L3=+49898012345]Telefon[/L3]
​
Zwischen Aufzählung, nummerierter Liste, Hervorhebung, Link, Mail und Telefon (oben): Abstand AH.
​
[S2]Punkt 1
Punkt 2[/S2]
​
[S3]Nummer 1
Nummer 2[/S3]
​
[S4]Hervorgehoben[/S4]
​
[L1=www.google.de]Link[/L1]
​
[L2=info@hanako-health.com]Mail[/L2]
​
[L3=+49898012345]Telefon[/L3]
​
Zwischen Aufzählung, nummerierter Liste, Hervorhebung, Link, Mail und Telefon (oben): Abstand AH (Leerzeilen werden ignoriert).
​
​
​
Zwischen dieser Zeile und der Zeile darüber: Abstand A1 (bis auf ein Leerzeichen werden alle Leerzeichen ignoriert).
[IMG=Service_Foto_Reise /]
Vor und nach dem Bild: Abstand A1.
​
[L1=www.google.de]Link[/L1]
[IMG=Service_Foto_Reise /]
[S4]Hervorgehoben[/S4]
Vor und nach dem Bild: Abstand A1.​
"""
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Setup view
		
        let scroll = UIScrollView()
        let rtfView = TestRTFView()
		scroll.addSubview(rtfView)
        view.addSubview(scroll)
        
        
        
		scroll.snp.makeConstraints {
            $0.edges.equalToSuperview()
			$0.top.equalTo(44)
            $0.bottom.equalTo(-34)
        }
        
        rtfView.snp.makeConstraints {
            $0.top.equalTo(44)
            $0.bottom.equalTo(-34)
            $0.left.equalTo(8)
            $0.right.equalTo(-8)
            $0.width.equalTo(UIScreen.main.bounds.width - 16)
        }
		
		// Trigger parsing and view building
		rtfView.text = testString3
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory? Never heard of that...")
    }

}

