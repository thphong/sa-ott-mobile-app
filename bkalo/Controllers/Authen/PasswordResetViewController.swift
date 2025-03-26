//
//  PasswordResetViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 24/3/25.
//

import UIKit

final class PasswordResetViewController: UIViewController {
    
    private var lblTitle: UILabel!
    private var lblPassword: UILabel!
    private var tfPassword: UITextField!
    private var lblConfirmPassword: UILabel!
    private var tfConfirmPassword: UITextField!
    private var btnConfirm: UIButton!
    
    override func loadView() {
        super.loadView()
        
        lblTitle = UILabel()
        lblTitle.text = "Thiết lập mật khẩu"
        lblTitle.textColor = .appleBlue
        lblTitle.font = .interBold(24)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        lblConfirmPassword = UILabel()
        lblConfirmPassword.text = "Xác nhận mật khẩu"
        lblConfirmPassword.textColor = .black
        lblConfirmPassword.font = .interMedium(16)
        lblConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        
        tfConfirmPassword = PaddingTextField(padding: 16)
        tfConfirmPassword.delegate = self
        tfConfirmPassword.font = .interRegular(16)
        tfConfirmPassword.backgroundColor = .platinumGray
        tfConfirmPassword.attributedPlaceholder = createPlaceholderAttributedString("Nhập lại mật khẩu")
        tfConfirmPassword.layer.cornerRadius = 10
        tfConfirmPassword.layer.masksToBounds = true
        tfConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        
        let confirmTitle = "Hoàn tất"
        let confirmAttrs = [NSAttributedString.Key.font: UIFont.interMedium(18), NSAttributedString.Key.foregroundColor: UIColor.white]
        let confirmString = NSMutableAttributedString(string: confirmTitle, attributes: confirmAttrs as [NSAttributedString.Key : Any])
        
        btnConfirm = UIButton(type: .system)
        btnConfirm.backgroundColor = .brightRoyalBlue
        btnConfirm.setAttributedTitle(confirmString, for: .normal)
        btnConfirm.layer.cornerRadius = 10
        btnConfirm.translatesAutoresizingMaskIntoConstraints = false
        btnConfirm.addTarget(self, action: #selector(actionConfirm), for: .touchUpInside)
        
        view.addSubview(lblTitle)
        view.addSubview(lblPassword)
        view.addSubview(tfPassword)
        view.addSubview(lblConfirmPassword)
        view.addSubview(tfConfirmPassword)
        view.addSubview(btnConfirm)
        
        NSLayoutConstraint.activate([
            lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -160),
            
            lblPassword.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 24),
            lblPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tfPassword.topAnchor.constraint(equalTo: lblPassword.bottomAnchor, constant: 16),
            tfPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfPassword.heightAnchor.constraint(equalToConstant: 48),
            
            lblConfirmPassword.topAnchor.constraint(equalTo: tfPassword.bottomAnchor, constant: 16),
            lblConfirmPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lblConfirmPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tfConfirmPassword.topAnchor.constraint(equalTo: lblConfirmPassword.bottomAnchor, constant: 16),
            tfConfirmPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfConfirmPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfConfirmPassword.heightAnchor.constraint(equalToConstant: 48),
            
            btnConfirm.topAnchor.constraint(equalTo: tfConfirmPassword.bottomAnchor, constant: 32),
            btnConfirm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnConfirm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnConfirm.heightAnchor.constraint(equalToConstant: 48)
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
    
    @objc private func actionConfirm() {
        guard let pwd = tfPassword.text, let pwdConfirm = tfConfirmPassword.text, pwd == pwdConfirm else { return }
        
        Utils.showDialogMessage(navigateBack: true)
    }
}

extension PasswordResetViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.appleBlue.cgColor
        textField.layer.borderWidth = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = nil
        textField.layer.borderWidth = 0
    }
}

extension PasswordResetViewController {
    private func createPlaceholderAttributedString(_ placeholder: String) -> NSAttributedString {
        return NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.dimGray,
            NSAttributedString.Key.font: UIFont.interRegular(16)
        ])
    }
}
