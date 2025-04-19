//
//  ContactService.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 15/4/25.
//

import UIKit

import Foundation

final class ContactService {
    static let shared = ContactService()
    
    func searchContacts(query: String, completion: @escaping (Bool, [ChatPartner]?) -> Void) {
        guard let request = userRequest.searchUser(query: query) else {
            completion(false, nil)
            return
        }
        
        NetworkService.shared.sendRequest(request, parse: { (data) -> [ChatPartner]? in
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataArray = json["data"] as? [[String: Any]] else {
                return nil
            }
            
            let partners = dataArray.compactMap { ChatPartner(json: $0) }
            return partners
        }) { result in
            switch result {
            case .success(let partners):
                // If you want to return this to another layer, change the completion
                print("Partners found: \(partners.count)")
                completion(true, partners)
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
    
    func getFriends(completion: @escaping (Bool, [ChatPartner]?) -> Void) {
        guard let request = contactRequest.getFriends() else {
            completion(false, nil)
            return
        }
        
        NetworkService.shared.sendRequest(request, parse: { (data) -> [ChatPartner]? in
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataObject = json["data"] as? [String: Any],
                  let friendsArray = dataObject["friends"] as? [[String: Any]] else {
                return nil
            }
            
            let partners = friendsArray.compactMap { ChatPartner(json: $0) }
            return partners
        }) { result in
            switch result {
            case .success(let partners):
                print("Partners found: \(partners.count)")
                completion(true, partners)
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
    
    func getGroups(page: Int? = nil, limit: Int? = nil, completion: @escaping (Bool, [GroupChat]?) -> Void) {
        guard let request = contactRequest.getGroups(page, limit) else {
            completion(false, nil)
            return
        }
        
        NetworkService.shared.sendRequest(request, parse: { (data) -> [GroupChat]? in
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataObject = json["data"] as? [String: Any],
                  let groupsArray = dataObject["groups"] as? [[String: Any]] else {
                return nil
            }
            
            let groups = groupsArray.compactMap { GroupChat(json: $0) }
            return groups
        }) { result in
            switch result {
            case .success(let groups):
                print("Groups found: \(groups.count)")
                completion(true, groups)
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
}
