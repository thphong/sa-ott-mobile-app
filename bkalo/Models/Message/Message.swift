//
//  Message.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 15/4/25.
//

import MessageKit
import UIKit

struct ChatReaction {
    let emoji: String
    let count: Int
    let reactors: [ChatMember]
}

struct FileMetadata {
    let url: String
    let displayName: String
}

struct Message: MessageType {
    let sender: SenderType
    let messageId: String
    let sentDate: Date
    let kind: MessageKind
    
    // Extended metadata
    var reactions: [ChatReaction]?
    var file: FileMetadata?
}
