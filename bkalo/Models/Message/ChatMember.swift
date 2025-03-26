//
//  ChatMember.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 4/3/25.
//

import Foundation
import MessageKit

struct ChatMember: SenderType {
    let senderId: String
    let displayName: String
}

extension ChatMember: Decodable {
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case userNick = "userNick"
    }
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let userId = try values.decode(Int.self, forKey: .userId)
        self.senderId = "\(userId)"
        self.displayName = try values.decode(String.self, forKey: .userNick)
    }
}
