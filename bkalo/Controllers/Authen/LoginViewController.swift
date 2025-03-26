//
//  LoginViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 17/3/25.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private var lblTitle: UILabel!
    private var lblPhoneNumber: UILabel!
    private var tfPhoneNumber: PaddingTextField!
    private var lblPassword: UILabel!
    private var tfPassword: PaddingTextField!
    private var btnLogin: UIButton!
    private var lblForgot: UILabel!
    private var lblNoAccount: UILabel!
    
    override func loadView() {
        super.loadView()
        
        lblTitle = UILabel()
        lblTitle.text = "Đăng nhập"
        lblTitle.textColor = .appleBlue
        lblTitle.font = .interBold(24)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblPhoneNumber = UILabel()
        lblPhoneNumber.text = "Số điện thoại"
        lblPhoneNumber.textColor = .black
        lblPhoneNumber.font = .interMedium(16)
        lblPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        
        tfPhoneNumber = PaddingTextField(padding: 16)
        tfPhoneNumber.delegate = self
        tfPhoneNumber.font = .interRegular(16)
        tfPhoneNumber.backgroundColor = .platinumGray
        tfPhoneNumber.attributedPlaceholder = createPlaceholderAttributedString("Nhập số điện thoại")
        tfPhoneNumber.layer.cornerRadius = 10
        tfPhoneNumber.layer.masksToBounds = true
        tfPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        
        lblPassword = UILabel()
        lblPassword.text = "Mật khẩu"
        lblPassword.textColor = .black
        lblPassword.font = .interMedium(16)
        lblPassword.translatesAutoresizingMaskIntoConstraints = false
        
        tfPassword = PaddingTextField(padding: 16)
        tfPassword.delegate = self
        tfPassword.font = .interRegular(16)
        tfPassword.backgroundColor = .platinumGray
        tfPassword.attributedPlaceholder = createPlaceholderAttributedString("Nhập mật khẩu")
        tfPassword.layer.cornerRadius = 10
        tfPassword.layer.masksToBounds = true
        tfPassword.translatesAutoresizingMaskIntoConstraints = false
        
        let loginTitle = "Đăng nhập"
        let loginAttrs = [NSAttributedString.Key.font: UIFont.interMedium(18), NSAttributedString.Key.foregroundColor: UIColor.white]
        let loginString = NSMutableAttributedString(string: loginTitle, attributes: loginAttrs as [NSAttributedString.Key : Any])
        
        btnLogin = UIButton(type: .system)
        btnLogin.backgroundColor = .brightRoyalBlue
        btnLogin.setAttributedTitle(loginString, for: .normal)
        btnLogin.layer.cornerRadius = 10
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.addTarget(self, action: #selector(actionLogin), for: .touchUpInside)
        
        lblForgot = UILabel()
        lblForgot.text = "Quên mật khẩu?"
        lblForgot.textColor = .gray
        lblForgot.font = .interRegular(16)
        lblForgot.translatesAutoresizingMaskIntoConstraints = false
        
        lblNoAccount = UILabel()
        lblNoAccount.attributedText = createNoAccountAttributedString()
        lblNoAccount.translatesAutoresizingMaskIntoConstraints = false
        let noAccountTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapNoAccountLabel))
        noAccountTapRecognizer.numberOfTapsRequired = 1
        lblNoAccount.addGestureRecognizer(noAccountTapRecognizer)
        lblNoAccount.isUserInteractionEnabled = true
        
        view.addSubview(lblTitle)
        view.addSubview(lblPhoneNumber)
        view.addSubview(tfPhoneNumber)
        view.addSubview(lblPassword)
        view.addSubview(tfPassword)
        view.addSubview(btnLogin)
        view.addSubview(lblForgot)
        view.addSubview(lblNoAccount)
        
        NSLayoutConstraint.activate([
            lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -160),
            
            lblPhoneNumber.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 24),
            lblPhoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblPhoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tfPhoneNumber.topAnchor.constraint(equalTo: lblPhoneNumber.bottomAnchor, constant: 16),
            tfPhoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfPhoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfPhoneNumber.heightAnchor.constraint(equalToConstant: 48),
            
            lblPassword.topAnchor.constraint(equalTo: tfPhoneNumber.bottomAnchor, constant: 16),
            lblPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tfPassword.topAnchor.constraint(equalTo: lblPassword.bottomAnchor, constant: 16),
            tfPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfPassword.heightAnchor.constraint(equalToConstant: 48),
            
            btnLogin.topAnchor.constraint(equalTo: tfPassword.bottomAnchor, constant: 32),
            btnLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnLogin.heightAnchor.constraint(equalToConstant: 48),
            
            lblForgot.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 16),
            lblForgot.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lblNoAccount.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            lblNoAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .nearWhite
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .cornFlowerBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }

    @objc private func actionLogin() {
        SceneDelegate.sharedInstance?.switchToMainTabBar()
    }
    
    @objc private func tapNoAccountLabel() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.appleBlue.cgColor
        textField.layer.borderWidth = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = nil
        textField.layer.borderWidth = 0
    }
}

extension LoginViewController {
    private func createPlaceholderAttributedString(_ placeholder: String) -> NSAttributedString {
        return NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.dimGray,
            NSAttributedString.Key.font: UIFont.interRegular(16)
        ])
    }
    
    private func createNoAccountAttributedString() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "Chưa có tài khoản? ", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.midGray,
            NSAttributedString.Key.font: UIFont.interMedium(16)
        ])
        
        attributedString.append(NSAttributedString(string: "Đăng ký ngay", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.appleBlue,
            NSAttributedString.Key.font: UIFont.interMedium(16)
        ]))
        
        return attributedString
    }
}
