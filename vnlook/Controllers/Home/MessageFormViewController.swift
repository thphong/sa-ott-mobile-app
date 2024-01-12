//
//  MessageFormViewController.swift
//  vnlook
//
//  Created by Nguyễn Minh Tâm on 12/01/2024.
//

import UIKit

final class MessageFormViewController: UIViewController {
    private var lblTitle: UILabel!
    private var tfUsername: UITextField!
    private var tfEmail: UITextField!
    private var tfMessage: UITextField!
    
    override func loadView() {
        super.loadView()
        
        lblTitle = UILabel()
        lblTitle.text = "Send a Message"
        lblTitle.font = .interBold(20)
        lblTitle.textColor = .black
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        tfUsername = UITextField()
        tfUsername.placeholder = "Your Name..."
        tfUsername.font = .interMedium(16)
        tfUsername.textColor = .black
        tfUsername.layer.borderColor = UIColor.black.cgColor
        tfUsername.layer.cornerRadius = 10
        tfUsername.layer.borderWidth = 2
        tfUsername.translatesAutoresizingMaskIntoConstraints = false
        
        tfEmail = UITextField()
        tfEmail.placeholder = "Your Email..."
        tfEmail.font = .interMedium(16)
        tfEmail.textColor = .black
        tfEmail.layer.borderColor = UIColor.black.cgColor
        tfEmail.layer.cornerRadius = 10
        tfEmail.layer.borderWidth = 2
        tfEmail.translatesAutoresizingMaskIntoConstraints = false
        
        tfMessage = UITextField()
        tfMessage.placeholder = "Your Name..."
        tfMessage.font = .interMedium(16)
        tfMessage.textColor = .black
        tfMessage.layer.borderColor = UIColor.black.cgColor
        tfMessage.layer.cornerRadius = 10
        tfMessage.layer.borderWidth = 2
        tfMessage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lblTitle)
        view.addSubview(tfUsername)
        view.addSubview(tfEmail)
        view.addSubview(tfMessage)
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tfUsername.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            tfUsername.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfUsername.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfUsername.heightAnchor.constraint(equalToConstant: 32),
            
            tfEmail.topAnchor.constraint(equalTo: tfUsername.bottomAnchor, constant: 16),
            tfEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfEmail.heightAnchor.constraint(equalToConstant: 32),
            
            tfMessage.topAnchor.constraint(equalTo: tfEmail.bottomAnchor, constant: 16),
            tfMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfMessage.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

}
