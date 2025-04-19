//
//  ChatMember.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 4/3/25.
//

import Foundation
import MessageKit

struct ChatMember: SenderType, Codable {
    let senderId: String
    let displayName: String
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case senderId = "id"
        case displayName = "full_name"
        case avatarURL = "avatar_url"
    }

    func toDictionary() -> [String: Any] {
        return [
            "id": Int(senderId) ?? 0,
            "full_name": displayName,
            "avatar_url": avatarURL ?? ""
        ]
    }
}
