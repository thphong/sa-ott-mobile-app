//
//  LoginOTPViewController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 22/3/25.
//

import UIKit

final class LoginOTPViewController: UIViewController {
    private var lblTitle: UILabel!
    private var otpView: OTPFieldView!
    private var otpString: String = ""
    private var btnConfirm: UIButton!
    
    override func loadView() {
        super.loadView()
        
        lblTitle = UILabel()
        lblTitle.text = "Confirmation code"
        lblTitle.textColor = .appleBlue
        lblTitle.font = .interBold(24)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        otpView = OTPFieldView()
        otpView.delegate = self
        otpView.fieldsCount = 6
        otpView.fieldBorderWidth = 2
        otpView.defaultBackgroundColor = .clear
        otpView.defaultBorderColor = UIColor.charcoalBrown
        otpView.filledBorderColor = UIColor.charcoalBrown
        otpView.displayType = .underlinedBottom
        otpView.otpInputType = .numeric
        otpView.separatorSpace = 8
        otpView.translatesAutoresizingMaskIntoConstraints = false
        
        let confirmTitle = "Confirm"
        let confirmAttrs = [NSAttributedString.Key.font: UIFont.interMedium(18), NSAttributedString.Key.foregroundColor: UIColor.white]
        let confirmString = NSMutableAttributedString(string: confirmTitle, attributes: confirmAttrs as [NSAttributedString.Key : Any])
        
        btnConfirm = UIButton(type: .system)
        btnConfirm.backgroundColor = .gray
        btnConfirm.setAttributedTitle(confirmString, for: .normal)
        btnConfirm.layer.cornerRadius = 10
        btnConfirm.translatesAutoresizingMaskIntoConstraints = false
        btnConfirm.addTarget(self, action: #selector(actionConfirm), for: .touchUpInside)
        
        view.addSubview(lblTitle)
        view.addSubview(otpView)
        view.addSubview(btnConfirm)
        
        NSLayoutConstraint.activate([
            lblTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -160),
            
            otpView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 16),
            otpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            otpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            otpView.heightAnchor.constraint(equalToConstant: 64),
            
            btnConfirm.topAnchor.constraint(equalTo: otpView.bottomAnchor, constant: 32),
            btnConfirm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            btnConfirm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnConfirm.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .nearWhite
        
        self.view.layoutIfNeeded()
        let spacing = CGFloat(otpView.fieldsCount - 1) * otpView.separatorSpace
        let size = (otpView.bounds.width - spacing) / CGFloat(otpView.fieldsCount)
        otpView.fieldSize = size
        otpView.initializeUI()
    }
    
    @objc private func actionConfirm() {
        AuthenManager.shared.verifyCode(otpCode: otpString) { [weak self] success in
            guard success else { return }
            self?.navigationController?.pushViewController(PasswordResetViewController(), animated: true)
        }
    }
}

extension LoginOTPViewController: OTPFieldViewDelegate {
    func enteredOTP(otp: String) {
        otpString = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        if hasEnteredAll {
            btnConfirm.isEnabled = true
            btnConfirm.backgroundColor = .brightRoyalBlue
            return true
        } else {
            btnConfirm.isEnabled = false
            btnConfirm.backgroundColor = .gray
            return false
        }
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
}
