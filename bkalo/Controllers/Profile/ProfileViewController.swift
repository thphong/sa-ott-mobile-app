//
//  ProfileViewController.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 09/01/2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    private var topContentView: UIView!
    private var subContentView: UIView!
    private var imgView: UIImageView!
    private var lblAvatar: UILabel!
    private var stackView: UIStackView!
    private var btnUpdate: UIButton!
    
    override func loadView() {
        super.loadView()
        
        topContentView = UIView()
        topContentView.backgroundColor = UIColor(hexString: "#027368")
        topContentView.translatesAutoresizingMaskIntoConstraints = false
        
        subContentView = UIView()
        subContentView.backgroundColor = .white
        subContentView.translatesAutoresizingMaskIntoConstraints = false
        
        imgView = UIImageView()
        imgView.image = UIImage(named: "testing")?.withRenderingMode(.alwaysOriginal)
        imgView.contentMode = .scaleAspectFill
        imgView.layer.borderWidth = 5
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.masksToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        lblAvatar = UILabel()
        lblAvatar.text = "Change avatar"
        lblAvatar.font = .interMedium(14)
        lblAvatar.textColor = .black
        lblAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let username = createSubview("Tên đăng nhập", "tamnguyen")
        let email = createSubview("Email", "tamnguyen@vnpt.vn")
        let phone = createSubview("Số điện thoại", "0915567796")
        let pwd = createSubview("Mật khẩu", "tamnguyen123")
        
        let title = "Update"
        let attrs = [NSAttributedString.Key.font: UIFont.interBold(20), NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalString = NSMutableAttributedString(string: title, attributes: attrs as [NSAttributedString.Key : Any])
        
        btnUpdate = UIButton(type: .system)
        btnUpdate.backgroundColor = UIColor(hexString: "#027368")
        btnUpdate.setAttributedTitle(normalString, for: .normal)
        btnUpdate.layer.cornerRadius = 10
        btnUpdate.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(username)
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(phone)
        stackView.addArrangedSubview(pwd)
        subContentView.addSubview(lblAvatar)
        subContentView.addSubview(stackView)
        subContentView.addSubview(btnUpdate)
        view.addSubview(topContentView)
        view.addSubview(subContentView)
        view.addSubview(imgView)
        
        NSLayoutConstraint.activate([
            topContentView.topAnchor.constraint(equalTo: view.topAnchor),
            topContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 4),
            
            subContentView.topAnchor.constraint(equalTo: topContentView.bottomAnchor),
            subContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: topContentView.bottomAnchor),
            imgView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3),
            imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor),
            
            lblAvatar.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 8),
            lblAvatar.centerXAnchor.constraint(equalTo: subContentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: lblAvatar.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: subContentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: subContentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: btnUpdate.topAnchor, constant: -8),
            
            btnUpdate.centerXAnchor.constraint(equalTo: subContentView.centerXAnchor),
            btnUpdate.widthAnchor.constraint(equalTo: subContentView.widthAnchor, multiplier: 2 / 3),
            btnUpdate.heightAnchor.constraint(equalToConstant: 48),
            btnUpdate.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgView.layer.cornerRadius = imgView.bounds.height / 2
    }
    
    @objc private func actionBack() {
        
    }
    
    private func createSubview(_ title: String, _ value: String = "") -> UIView {
        let subView = UIView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        let lblTitle = UILabel()
        lblTitle.text = title
        lblTitle.font = .interMedium(14)
        lblTitle.textColor = .black
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let tfView = UITextField()
        tfView.placeholder = value
        tfView.textColor = .black
        tfView.translatesAutoresizingMaskIntoConstraints = false
        
        subView.addSubview(lblTitle)
        subView.addSubview(tfView)
        
        NSLayoutConstraint.activate([
            tfView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor)
        ])
        
        return subView
    }
}
