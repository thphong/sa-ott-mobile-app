//
//  GroupChat.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 16/4/25.
//

import Foundation

struct GroupChat {
    let id: Int
    let name: String
    let type: String
    let createdBy: Int
    let visible: Bool
    let memberCount: Int
    let avatarURL: String?
    var members: [ChatPartner]

    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
              let name = json["name"] as? String,
              let type = json["type"] as? String,
              let createdBy = json["created_by"] as? Int,
              let visible = json["visible"] as? Bool,
              let memberCount = json["member_count"] as? Int,
              let avatarURL = json["avatar_url"] as? String,
              let membersJSON = json["members"] as? [[String: Any]] else {
            return nil
        }

        self.id = id
        self.name = name
        self.type = type
        self.createdBy = createdBy
        self.visible = visible
        self.memberCount = memberCount
        self.avatarURL = avatarURL

        self.members = membersJSON.compactMap { ChatPartner(json: $0) }
    }
}
