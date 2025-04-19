//
//  AuthenManager.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 24/3/25.
//

import UIKit
import FirebaseAuth
import SwiftyJSON

final class AuthenManager {
    static let shared = AuthenManager()
    
    private let auth = Auth.auth()
    private var verificationID: String?
    var phoneNumber: String?
    
    private func saveAuthModel(_ model: AuthenModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            UserDefaults.standard.set(encoded, forKey: "authenModel")
            UserDefaults.standard.synchronize()
        }
    }

    // Add this to retrieve the saved model
    static func getSavedAuthModel() -> AuthenModel? {
        if let savedData = UserDefaults.standard.data(forKey: "authenModel") {
            let decoder = JSONDecoder()
            return try? decoder.decode(AuthenModel.self, from: savedData)
        }
        return nil
    }

    // Add this to clear the saved model
    static func clearAuthModel() {
        UserDefaults.standard.removeObject(forKey: "authenModel")
        UserDefaults.standard.synchronize()
    }
    
    static func updateAuthModel(name: String?, avatar: String?) {
        guard let currentModel = getSavedAuthModel() else {
            print("No existing auth model to update.")
            return
        }

        if let newName = name {
            currentModel.name = newName
        }
        if let newAvatar = avatar {
            currentModel.avatar = newAvatar
        }

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currentModel) {
            UserDefaults.standard.set(encoded, forKey: "authenModel")
            UserDefaults.standard.synchronize()
        }
    }

    
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
    
    func startLoginAuthen(phoneNumber: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard let request = authenRequest.authenApp(phoneNumber: phoneNumber, password: password) else {
            completion(false, "Invalid request.")
            return
        }

        NetworkService.shared.sendRequest(request, parse: { (data) -> AuthenModel? in
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataDict = json["data"] as? [String: Any],
                  let jsonData = try? JSONSerialization.data(withJSONObject: dataDict),
                  let jsonObject = try? JSON(data: jsonData) else {
                return nil
            }
            
            return AuthenModel(jsonObject)
        }) { result in
            switch result {
            case .success(let authModel):
                self.saveAuthModel(authModel)
                print("Login successful. Access Token: \(authModel.accessToken)")
                completion(true, nil)
            case .failure(let error):
                switch error {
                case .server(let message):
                    completion(false, message)
                case .statusCode(let code):
                    completion(false, "Unexpected status code: \(code)")
                default:
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    func startRegisterAuthen(phoneNumber: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard let request = authenRequest.registerApp(phoneNumber: phoneNumber, password: password) else {
            completion(false, "Invalid request.")
            return
        }
        
        NetworkService.shared.sendRequest(request, parse: { (data) -> String? in
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataDict = json["data"] as? [String: Any] else {
                return nil
            }
            guard let userId = dataDict["id"] as? Int else { return nil }
            return String(userId)
        }) { result in
            switch result {
            case .success(let userId):
                print("User ID: \(userId)") 
                completion(true, nil)
            case .failure(let error):
                switch error {
                case .server(let message):
                    completion(false, message)
                case .statusCode(let code):
                    completion(false, "Unexpected status code: \(code)")
                default:
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    func logoutApp(completion: @escaping (Bool) -> Void) {
        guard let request = authenRequest.logoutApp() else {
            completion(false)
            return
        }
        
        completion(true)
    }
}
