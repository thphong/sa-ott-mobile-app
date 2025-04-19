//
//  UserService.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 19/4/25.
//

import Foundation
import SwiftyJSON

final class UserService {
    static let shared = UserService()
    
    func getCurrentInfo(completion: @escaping (Bool, UserModel?) -> Void) {
        guard let request = userRequest.getCurrentInfo() else {
            completion(false, nil)
            return
        }
        
        NetworkService.shared.sendRequest(request, parse: { data in
            let json = try? JSON(data: data)
            if let dataJson = json?["data"] {
                return UserModel(dataJson)
            }
            
            return nil
        }) { result in
            switch result {
            case .success(let userModel):
                print("UserModel is saved!")
                completion(true, userModel)
            case .failure(let error):
                switch error {
                case .server(let message):
                    print("Error message: \(message)")
                    completion(false, nil)
                case .statusCode(let code):
                    print("Error code: \(code)")
                    completion(false, nil)
                default:
                    completion(false, nil)
                }
            }
        }
    }
    
    func updateInfo(name: String?, avatarURL: String?, completion: @escaping (Bool) -> Void) {
        guard let request = userRequest.updateInfo(name: name, avatarURL: avatarURL) else {
            completion(false)
            return
        }
        
        NetworkService.shared.sendRequestWithoutParsing(request) { result in
            switch result {
            case .success(let data):
                print("Update info successfully!")
                completion(true)
            case .failure(let error):
                switch error {
                case .server(let message):
                    print("Error message: \(message)")
                    completion(false)
                case .statusCode(let code):
                    print("Error code: \(code)")
                    completion(false)
                default:
                    completion(false)
                }
            }
        }
    }
}
