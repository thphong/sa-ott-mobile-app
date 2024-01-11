//
//  CardContentViewController.swift
//  vnlook
//
//  Created by Nguyen Minh Tam on 11/01/2024.
//

import UIKit

class CardContentViewController: UIViewController {
    private var imgView: UIImageView!
    private var lblTitle: UILabel!
    private var lblDesc: UILabel!
    
    override func loadView() {
        super.loadView()
        
        imgView = UIImageView()
        imgView.image = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle = UILabel()
        lblTitle.text = "Tam Nguyen"
        lblTitle.font = .interBold(24)
        lblTitle.textColor = .black
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblDesc = UILabel()
        lblDesc.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        lblDesc.font = .interRegular(16)
        lblDesc.textColor = .black
        lblDesc.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imgView)
        view.addSubview(lblTitle)
        view.addSubview(lblDesc)
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: view.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imgView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3),
            
            lblTitle.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 16),
            lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            lblDesc.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            lblDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
