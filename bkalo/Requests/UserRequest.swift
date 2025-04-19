//
//  UserRequest.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 15/4/25.
//

import Foundation

let userRequest = UserRequest()

final class UserRequest: Requests {
    func searchUser(query: String) -> URLRequest? {
        guard let baseURL = BASE_URL else { return nil }
        var params = requiredParams
        params["text"] = query
        
        var components = URLComponents(url: baseURL.appendingPathComponent("users"), resolvingAgainstBaseURL: false)!
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        if let urlString = components.url?.absoluteString {
            print("Full API URL: \(urlString)")
        }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        return request
    }
    
    func getCurrentInfo() -> URLRequest? {
        guard let baseURL = BASE_URL else { return nil }
        
        let components = URLComponents(url: baseURL.appendingPathComponent("users/me"), resolvingAgainstBaseURL: false)!
        
        if let urlString = components.url?.absoluteString {
            print("Full API URL: \(urlString)")
        }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        return request
    }
    
    func updateInfo(name: String?, avatarURL: String?) -> URLRequest? {
        guard let baseURL = BASE_URL else { return nil }
        var params = [:].merging(requiredParams, uniquingKeysWith: { _, new in new })
        params["is_active"] = true
        if name != nil { params["full_name"] = name }
        if avatarURL != nil { params["avatar_url"] = avatarURL }
        
        let components = URLComponents(url: baseURL.appendingPathComponent("users/me"), resolvingAgainstBaseURL: false)!
        
        if let urlString = components.url?.absoluteString {
            print("Full API URL: \(urlString)")
        }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = params.toJSON().data(using: .utf8)
        request.httpMethod = "PUT"
        
        return request
    }
}
