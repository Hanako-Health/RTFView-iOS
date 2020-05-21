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
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(8)
            $0.right.equalTo(-8)
            $0.width.equalTo(UIScreen.main.bounds.width - 16)
        }
		
		// Trigger parsing and view building
		rtfView.text = "[S4]Erste Zeile [SP=2 /] Zweite Zeile[/S4]"
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory? Never heard of that...")
    }
    
        let testString3 = """
    [S1]Test der Formatierungen[/S1]
    [B]Dieser Satz ist fett.[/B]
    [I]Dieser Satz ist kursiv.[/I]
    [U]Dieser Satz ist unterstrichen.[/U]
    Dieser Satz enthält [B]fette Worte[/B] und [I]kursive Worte[/I] und [U]unterstrichene Worte[/U] und endet in normaler Schrift. Die trennenden "und" sind nicht formatiert. [B][I][U]Dieser Satz schließt sich unmittelbar an und ist mit allen Formatierungsoptionen gleichzeitig formatiert.[/U][/I][/B]
    [S1]Eine Zwischenüberschrift[/S1]
    Eine Liste mit Punkten, wie alle Listen grau hinterlegt. Der zweite Eintrag ist fett, der dritte kursiv, der vierte unterstrichen:
    [S2]Eins
    [B]Zwei[/B]
    [I]Drei[/I]
    [U]Vier[/U][/S2]
    Eine nummerierte Liste, wie alle Listen grau hinterlegt. Der erste Eintrag ist fett, der zweite kursiv, der dritte unterstrichen:
    [S3][B]Eins[/B]
    [I]Zwei[/I]
    [U]Drei[/U]
    Vier[/S3]
    [S4]Ein Text in einem grauen [B]Kasten[/B], der ihn hervorhebt. Das Wort "Kasten" ist fett.[/S4]
    Drei Linkelemente:
    [L1=www.google.de]Externer Link zu Google mit Link-Symbol[/L1]
    [L2=info@hanako-health.com]Info-Adresse von Hanako mit Mail-Symbol[/L2]
    [L3=0898012345]Fiktive Telefonnummer mit Hörer-Symbol[/L3]
    Ein Bild. Darunter ein Text in einem grauen Kasten. Der Kasten ist so breit wie das Bild:
    [IMG=Service_Foto_Reise /]
    [S4][U]Dieser Text wird in einem grauen Kasten angezeigt und ist unterstrichen.[/U][/S4]
    [S1]Test der Abstände[/S1]
    Vor der Zwischenüberschrift oben: Abstand A2. Darunter: Abstand A1 (Leerzeilen werden ignoriert).
    Zeile 1
    Zeile 2
    Vor Zeile 1: Abstand A1. Zwischen Zeile 1 und Zeile 2: Abstand A0. Nach Zeile 2: Abstand A1 (Leerzeilen werden nicht ignoriert).
    [S2]Punkt 1
    Punkt 2[/S2]
    [S3]Nummer 1
    Nummer 2[/S3]
    [S4]Hervorgehoben[/S4]
    [L1=www.google.de]Link[/L1]
    [L2=info@hanako-health.com]Mail[/L2]
    [L3=+49898012345]Telefon[/L3]
    Zwischen Aufzählung, nummerierter Liste, Hervorhebung, Link, Mail und Telefon (oben): Abstand AH.
    [S2]Punkt 1
    Punkt 2[/S2]
    [S3]Nummer 1
    Nummer 2[/S3]
    [S4]Hervorgehoben[/S4]
    [L1=www.google.de]Link[/L1]
    [L2=info@hanako-health.com]Mail[/L2]
    [L3=+49898012345]Telefon[/L3]
    Zwischen Aufzählung, nummerierter Liste, Hervorhebung, Link, Mail und Telefon (oben): Abstand AH (Leerzeilen werden ignoriert).
    Zwischen dieser Zeile und der Zeile darüber: Abstand A1 (bis auf ein Leerzeichen werden alle Leerzeichen ignoriert).
    [IMG=Service_Foto_Reise /]
    Vor und nach dem Bild: Abstand A1.
    [L1=www.google.de]Link[/L1]
    [IMG=Service_Foto_Reise /]
    [S4]Hervorgehoben[/S4]
    Vor und nach dem Bild: Abstand A1.
    """

}

