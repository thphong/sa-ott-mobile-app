//
//  AuthenManager.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 24/3/25.
//

import UIKit
import FirebaseAuth

final class AuthenManager {
    static let shared = AuthenManager()
    
    private let auth = Auth.auth()
    private var verificationID: String?
    
    func startAuthen(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print("Failed to start authen: \(error.localizedDescription)")
                completion(false)
                return
            }
            self.verificationID = verificationID
            completion(true)
        }
    }
    
    func verifyCode(otpCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationID = verificationID else {
            print("Failed to verify code: verificationID is nil")
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: otpCode
        )
        
        auth.signIn(with: credential) { (authDataResult, error) in
            if let error = error {
                print("Failed to verify code: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
}
