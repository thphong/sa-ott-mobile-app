//
//  AuthenRequest.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 14/4/25.
//

import Foundation

let authenRequest = AuthenRequest()

final class AuthenRequest: Requests {
    func authenApp(phoneNumber: String, password: String) -> URLRequest? {
        guard let url = BASE_URL else { return nil }
        var params = [:].merging(requiredParams, uniquingKeysWith: { _, new in new})
        params["phone"] = phoneNumber
        params["password"] = password
        
        var request = URLRequest(url: url.appendingPathComponent("auth/login"))
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = params.toJSON().data(using: .utf8)
        request.httpMethod = "POST"
        return request
    }
    
    func registerApp(phoneNumber: String, password: String) -> URLRequest? {
        guard let url = BASE_URL else { return nil }
        var params = [:].merging(requiredParams, uniquingKeysWith: { _, new in new})
        params["phone"] = phoneNumber
        params["full_name"] = ""
        params["password"] = password
        params["avatar_url"] = ""
        
        var request = URLRequest(url: url.appendingPathComponent("auth/register"))
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = params.toJSON().data(using: .utf8)
        request.httpMethod = "POST"
        return request
    }
    
    func logoutApp() -> URLRequest? {
        guard let url = BASE_URL else { return nil }
        
        var request = URLRequest(url: url.appendingPathComponent("auth/logout"))
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        return request
    }
}
