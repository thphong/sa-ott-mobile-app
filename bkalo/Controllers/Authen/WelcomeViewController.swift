//
//  WelcomeViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 17/3/25.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private var imgView: UIImageView!
    private var btnLogin: UIButton!
    private var btnRegister: UIButton!
    
    override func loadView() {
        super.loadView()
        
        imgView = UIImageView()
        imgView.image = UIImage(named: "bkalo-logo")?.withRenderingMode(.alwaysOriginal)
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        let loginTitle = "Đăng nhập"
        let loginAttrs = [NSAttributedString.Key.font: UIFont.interMedium(18), NSAttributedString.Key.foregroundColor: UIColor.white]
        let loginString = NSMutableAttributedString(string: loginTitle, attributes: loginAttrs as [NSAttributedString.Key : Any])
        
        btnLogin = UIButton(type: .system)
        btnLogin.backgroundColor = .brightRoyalBlue
        btnLogin.setAttributedTitle(loginString, for: .normal)
        btnLogin.layer.cornerRadius = 10
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.addTarget(self, action: #selector(actionLogin), for: .touchUpInside)
        
        let registerTitle = "Tạo tài khoản mới"
        let registerAttrs = [NSAttributedString.Key.font: UIFont.interMedium(18), NSAttributedString.Key.foregroundColor: UIColor.black]
        let registerString = NSMutableAttributedString(string: registerTitle, attributes: registerAttrs as [NSAttributedString.Key : Any])
        
        btnRegister = UIButton(type: .system)
        btnRegister.backgroundColor = .athensGray
        btnRegister.setAttributedTitle(registerString, for: .normal)
        btnRegister.layer.cornerRadius = 10
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        btnRegister.addTarget(self, action: #selector(actionRegister), for: .touchUpInside)
        
        view.addSubview(imgView)
        view.addSubview(btnLogin)
        view.addSubview(btnRegister)
        
        NSLayoutConstraint.activate([
            imgView.widthAnchor.constraint(equalToConstant: 240),
            imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor),
            imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -24),
            
            btnLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            btnLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            btnLogin.heightAnchor.constraint(equalToConstant: 48),
            
            btnRegister.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 16),
            btnRegister.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            btnRegister.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            btnRegister.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            btnRegister.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .nearWhite
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    @objc func actionLogin() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func actionRegister() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}

extension WelcomeViewController {
    func autoPressLoginButton() {
        btnLogin.sendActions(for: .touchUpInside)
    }
}
