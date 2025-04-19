//
//  ContactRequest.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 16/4/25.
//

import Foundation

let contactRequest = ContactRequest()

final class ContactRequest: Requests {
    func getFriends() -> URLRequest? {
        guard let baseURL = BASE_URL else { return nil }
        let components = URLComponents(url: baseURL.appendingPathComponent("friends"), resolvingAgainstBaseURL: false)!

        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
    
    func getGroups(_ page: Int?, _ limit: Int?) -> URLRequest? {
        guard let baseURL = BASE_URL else { return nil }
        
        var params = requiredParams
        if let page = page { params["page"] = "\(page)" }
        if let limit = limit { params["limit"] = "\(limit)" }
        
        var components = URLComponents(url: baseURL.appendingPathComponent("groups"), resolvingAgainstBaseURL: false)!
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return request
    }
    
//    func addFriend() -> URLRequest? {
//        guard let baseURL = BASE_URL else { return nil }
//        let components = URLComponents(url: baseURL.appendingPathComponent("friends/"), resolvingAgainstBaseURL: false)!
//
//        guard let url = components.url else { return nil }
//        var request = URLRequest(url: url)
//        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "GET"
//        return request
//    }
}
