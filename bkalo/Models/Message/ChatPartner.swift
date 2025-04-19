//
//  ChatPartner.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 15/4/25.
//

import Foundation

struct ChatPartner {
    let id: Int
    let name: String
    let isOnline: Bool
    let lastSeen: Date?
    let avatarURL: String?
    let role: String? // Only used for group members
    var fullAvatarURL: URL?
    
    // General initializer
    init(id: Int, name: String, isOnline: Bool, lastSeen: Date?, avatarURL: String?, role: String? = nil) {
        self.id = id
        self.name = name
        self.isOnline = isOnline
        self.lastSeen = lastSeen
        self.avatarURL = avatarURL
        self.role = role
    }

    // Init from contact-style JSON
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
              let fullName = json["full_name"] as? String,
              let avatarURL = json["avatar_url"] as? String,
              let isActive = json["is_active"] as? Bool else {
            return nil
        }

        self.id = id
        self.name = fullName
        self.isOnline = isActive
        self.avatarURL = avatarURL
        self.lastSeen = nil
        self.role = nil
    }

    // Init from GroupMember JSON
    init?(groupJSON: [String: Any]) {
        guard let id = groupJSON["id"] as? Int,
              let name = groupJSON["name"] as? String,
              let avatarURL = groupJSON["avatar_url"] as? String,
              let role = groupJSON["role"] as? String,
              let isOnline = groupJSON["is_online"] as? Bool else {
            return nil
        }

        self.id = id
        self.name = name
        self.isOnline = isOnline
        self.avatarURL = avatarURL
        self.lastSeen = nil
        self.role = role
    }
}
