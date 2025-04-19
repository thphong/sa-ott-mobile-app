//
//  ChatRequest.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 17/4/25.
//

import Foundation

let chatRequest = ChatRequest()

final class ChatRequest: Requests {
    func getGroupId(id: Int) -> URLRequest? {
        guard let baseURL = BASE_URL else { return nil }
        let components = URLComponents(url: baseURL.appendingPathComponent("groups/private/\(id)"), resolvingAgainstBaseURL: false)!
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        print("Final Request:")
        print(request.url!.absoluteString)
        print(request.allHTTPHeaderFields!)
        
        return request
    }
    
    func getChatList(groupId: Int) -> URLRequest? {
        guard let baseURL = BASE_URL else { return nil }
        let components = URLComponents(url: baseURL.appendingPathComponent("chats/chat/\(groupId)"), resolvingAgainstBaseURL: false)!
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        print("Final Request:")
        print(request.url!.absoluteString)
        print(request.allHTTPHeaderFields!)
        
        return request
    }
    
//    func getPublicFile(key: String, isPublic: Bool) -> URLRequest? {
//        guard let baseURL = BASE_URL else { return nil }
//        var params = requiredParams
//        params["s3_key"] = key
//        params["is_public"] = isPublic
//        
//        var request = URLRequest(url: baseURL.appendingPathComponent("medias/get-public-file-url?"))
//        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
//        request.httpBody = params.percentEscaped().data(using: .utf8)
//        request.httpMethod = "GET"
//        
//        print("Final Request:")
//        print(request.url!.absoluteString)
//        print(request.allHTTPHeaderFields!)
//        
//        return request
//    }
    
    func getPublicFile(key: String, isPublic: Bool) -> URLRequest? {
        guard let baseURL = BASE_URL else { return nil }
        var components = URLComponents(url: baseURL.appendingPathComponent("medias/get-public-file-url"), resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "s3_key", value: key),
            URLQueryItem(name: "is_public", value: isPublic ? "true" : "false")
        ]
        
        guard let finalURL = components?.url else { return nil }

        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        print("Final Request:")
        print(request.url!.absoluteString)
        print(request.allHTTPHeaderFields!)
        
        return request
    }

}
