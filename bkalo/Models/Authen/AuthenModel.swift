//
//  AuthenModel.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 14/4/25.
//

import Foundation
import SwiftyJSON

final class AuthenModel: BaseModel, Codable {
    var id: Int = -1
    var name: String = ""
    var avatar: String = ""
    var accessToken: String = ""
    var tokenType: String = ""
    
    required init() {
        super.init()
    }
    
    override init(_ data: JSON) {
        super.init(data)
        
        if let id = data["id"].int {
            self.id = id
        }
        
        if let name = data["full_name"].string {
            self.name = name
        }
        
        if let avatar = data["avatar_url"].string {
            self.avatar = avatar
        }
        
        if let accessToken = data["access_token"].string {
            self.accessToken = accessToken
        }
        
        if let tokenType = data["token_type"].string {
            self.tokenType = tokenType
        }
    }
}
