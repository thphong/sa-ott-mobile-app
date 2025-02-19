//
//  MessageFormViewController.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 12/01/2024.
//

import UIKit

final class MessageFormViewController: UIViewController {
    private var lblTitle: UILabel!
    private var tfUsername: UITextField!
    private var tfEmail: UITextField!
    private var messageView: UITextView!
    
    override func loadView() {
        super.loadView()
        
        lblTitle = UILabel()
        lblTitle.text = "Send a Message"
        lblTitle.font = .interBold(20)
        lblTitle.textColor = .black
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        tfUsername = UITextField()
        tfUsername.placeholder = "Your name..."
        tfUsername.font = .interMedium(16)
        tfUsername.textColor = .black
        tfUsername.layer.borderColor = UIColor.black.cgColor
        tfUsername.layer.cornerRadius = 10
        tfUsername.layer.borderWidth = 1
        tfUsername.translatesAutoresizingMaskIntoConstraints = false
        
        tfEmail = UITextField()
        tfEmail.placeholder = "Your email..."
        tfEmail.font = .interMedium(16)
        tfEmail.textColor = .black
        tfEmail.layer.borderColor = UIColor.black.cgColor
        tfEmail.layer.cornerRadius = 10
        tfEmail.layer.borderWidth = 1
        tfEmail.translatesAutoresizingMaskIntoConstraints = false
        
        messageView = UITextView()
        messageView.delegate = self
        messageView.text = "Your message..."
        messageView.font = .interMedium(16)
        messageView.textColor = .lightGray
        messageView.layer.borderWidth = 1
        messageView.layer.borderColor = UIColor.black.cgColor
        messageView.layer.cornerRadius = 10
        messageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lblTitle)
        view.addSubview(tfUsername)
        view.addSubview(tfEmail)
        view.addSubview(messageView)
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tfUsername.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            tfUsername.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfUsername.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfUsername.heightAnchor.constraint(equalToConstant: 32),
            
            tfEmail.topAnchor.constraint(equalTo: tfUsername.bottomAnchor, constant: 16),
            tfEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfEmail.heightAnchor.constraint(equalToConstant: 32),
            
            messageView.topAnchor.constraint(equalTo: tfEmail.bottomAnchor, constant: 16),
            messageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            messageView.heightAnchor.constraint(equalTo: messageView.widthAnchor, multiplier: 1 / 2),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
}

extension MessageFormViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your message"
            textView.textColor = .lightGray
        }
    }
}
