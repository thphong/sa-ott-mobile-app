//
//  RegisterViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 18/3/25.
//

import UIKit
import PhoneNumberKit

final class RegisterViewController: UIViewController {
    private var lblTitle: UILabel!
    private var tfPhoneNumber: PhoneNumberTextField!
    private var btnCheckbox: UIButton!
    private var lblAgreement: UILabel!
    private var btnNext: UIButton!
    private var lblHaveAccount: UILabel!
    
    override func loadView() {
        super.loadView()
        
        lblTitle = UILabel()
        lblTitle.text = "Enter your phone number"
        lblTitle.textColor = UIColor.appleBlue
        lblTitle.font = .interBold(24)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        tfPhoneNumber = PhoneNumberTextField(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), clearButtonPadding: 0)
        tfPhoneNumber.font = .interRegular(16)
        tfPhoneNumber.backgroundColor = .platinumGray
        tfPhoneNumber.withPrefix = true
        tfPhoneNumber.withExamplePlaceholder = true
        tfPhoneNumber.attributedPlaceholder = createPlaceholderAttributedString("Enter your phone number")
        tfPhoneNumber.layer.cornerRadius = 10
        tfPhoneNumber.layer.masksToBounds = true
        tfPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        
        btnCheckbox = UIButton(type: .system)
        btnCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
        btnCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        btnCheckbox.tintColor = UIColor.appleBlue
        btnCheckbox.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        btnCheckbox.translatesAutoresizingMaskIntoConstraints = false
        
        lblAgreement = UILabel()
        let attributedText = NSMutableAttributedString(
            string: "I agree to the ",
            attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.interRegular(16)]
        )
        attributedText.append(NSAttributedString(
            string: "Terms & Policy",
            attributes: [.foregroundColor: UIColor.brightRoyalBlue, .font: UIFont.interMedium(16)]
        ))
        lblAgreement.attributedText = attributedText
        lblAgreement.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openPolicy))
        lblAgreement.addGestureRecognizer(tapGesture)
        lblAgreement.translatesAutoresizingMaskIntoConstraints = false
        
        let nextTitle = "Continue"
        let nextAttrs = [NSAttributedString.Key.font: UIFont.interMedium(18), NSAttributedString.Key.foregroundColor: UIColor.white]
        let nextString = NSMutableAttributedString(string: nextTitle, attributes: nextAttrs as [NSAttributedString.Key : Any])
        
        btnNext = UIButton(type: .system)
        btnNext.backgroundColor = .brightRoyalBlue
        btnNext.setAttributedTitle(nextString, for: .normal)
        btnNext.layer.cornerRadius = 10
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        btnNext.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        
        lblHaveAccount = UILabel()
        lblHaveAccount.attributedText = createHaveAccountAttributedString()
        lblHaveAccount.translatesAutoresizingMaskIntoConstraints = false
        let noAccountTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHaveAccountLabel))
        noAccountTapRecognizer.numberOfTapsRequired = 1
        lblHaveAccount.addGestureRecognizer(noAccountTapRecognizer)
        lblHaveAccount.isUserInteractionEnabled = true
        
        view.addSubview(lblTitle)
        view.addSubview(tfPhoneNumber)
        view.addSubview(btnCheckbox)
        view.addSubview(lblAgreement)
        view.addSubview(btnNext)
        view.addSubview(lblHaveAccount)
        
        NSLayoutConstraint.activate([
            lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -160),
            
            tfPhoneNumber.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 24),
            tfPhoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tfPhoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tfPhoneNumber.heightAnchor.constraint(equalToConstant: 48),
            
            btnCheckbox.topAnchor.constraint(equalTo: tfPhoneNumber.bottomAnchor, constant: 16),
            btnCheckbox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnCheckbox.widthAnchor.constraint(equalToConstant: 24),
            btnCheckbox.heightAnchor.constraint(equalToConstant: 24),
            
            lblAgreement.leadingAnchor.constraint(equalTo: btnCheckbox.trailingAnchor, constant: 8),
            lblAgreement.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lblAgreement.centerYAnchor.constraint(equalTo: btnCheckbox.centerYAnchor),
            
            btnNext.topAnchor.constraint(equalTo: btnCheckbox.bottomAnchor, constant: 32),
            btnNext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnNext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnNext.heightAnchor.constraint(equalToConstant: 48),
            
            lblHaveAccount.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            lblHaveAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
    
    @objc private func toggleCheckbox() {
        btnCheckbox.isSelected.toggle()
    }
    
    @objc private func openPolicy() {
        print("Open Terms & Policy screen")
        // TODO: Navigate to a Terms & Policy screen here
    }
    
    @objc private func actionNext() {
        AuthenManager.shared.startAuthen(phoneNumber: tfPhoneNumber.text ?? "") { [weak self] success in
            guard success else { return }
            AuthenManager.shared.phoneNumber = self?.tfPhoneNumber.text
            self?.navigationController?.pushViewController(LoginOTPViewController(), animated: true)
        }
    }
    
    @objc private func tapHaveAccountLabel() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}

extension RegisterViewController {
    private func createPlaceholderAttributedString(_ placeholder: String) -> NSAttributedString {
        return NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.dimGray,
            NSAttributedString.Key.font: UIFont.interRegular(16)
        ])
    }
    
    private func createHaveAccountAttributedString() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "Already have account? ", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.midGray,
            NSAttributedString.Key.font: UIFont.interMedium(16)
        ])
        
        attributedString.append(NSAttributedString(string: "Login now", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.appleBlue,
            NSAttributedString.Key.font: UIFont.interMedium(16)
        ]))
        
        return attributedString
    }
}
