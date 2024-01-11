//
//  AboutUsViewController.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 11/01/2024.
//

import UIKit
import Cards

final class AboutUsViewController: UIViewController {

    override func loadView() {
        super.loadView()
        view.backgroundColor = .brown
        let card = CardHighlight()

        card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
        card.icon = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        card.title = "Tam Nguyen"
        card.itemTitle = "Tech Dev"
        card.itemSubtitle = "HCMUT"
        card.textColor = UIColor.white
        card.buttonText = "View"
        card.hasParallax = true
            
        // let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "CardContent")
        // card.shouldPresent(cardContentVC, from: self, fullscreen: false)
        card.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            card.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 2),
            card.heightAnchor.constraint(equalTo: card.widthAnchor)
            // card.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
