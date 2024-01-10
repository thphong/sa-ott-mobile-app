//
//  SideMenuViewController.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 10/01/2024.
//

import UIKit

class SideMenuViewController: UIViewController {
    private var topView: UIView!
    private var imgAvatar: UIImageView!
    private var lblUsername: UILabel!
    private var lblEmail: UILabel!
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .blue
        
        topView = UIView()
        topView.backgroundColor = UIColor(hexString: "#04555c", transparency: 0.5)
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        imgAvatar = UIImageView()
        imgAvatar.image = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        imgAvatar.contentMode = .scaleAspectFill
        imgAvatar.layer.masksToBounds = true
        imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        lblUsername = UILabel()
        lblUsername.text = "tamnguyen"
        lblUsername.font = .interBold(14)
        lblUsername.textColor = .black
        lblUsername.translatesAutoresizingMaskIntoConstraints = false
        
        lblEmail = UILabel()
        lblEmail.text = "tamnguyen@vnpt.vn"
        lblEmail.font = .interRegular(12)
        lblEmail.textColor = .black
        lblEmail.translatesAutoresizingMaskIntoConstraints = false
        
        let detailView = UIStackView()
        detailView.axis = .vertical
        detailView.addArrangedSubview(lblUsername)
        detailView.addArrangedSubview(lblEmail)
        
        topView.addSubview(imgAvatar)
        topView.addSubview(detailView)
        view.addSubview(topView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3),
            
            imgAvatar.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8),
            imgAvatar.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 8),
            imgAvatar.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
            imgAvatar.widthAnchor.constraint(equalTo: imgAvatar.heightAnchor),
            
            detailView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8),
            detailView.leadingAnchor.constraint(equalTo: imgAvatar.trailingAnchor, constant: 8),
            detailView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            detailView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgAvatar.layer.cornerRadius = imgAvatar.bounds.height / 2
    }

}
