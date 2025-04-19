//
//  UserModel.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 19/4/25.
//

import Foundation
import SwiftyJSON

final class UserModel: BaseModel {
    var id: Int = -1
    var name: String = ""
    var avatar: String = ""
    var phone: String = ""
    var status: String = ""
    var isOnline: Bool = false
    
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
        
        if let phone = data["phone"].string {
            self.phone = phone
        }
        
        if let status = data["status"].string {
            self.status = status
        }
        
        if let isOnline = data["is_active"].bool {
            self.isOnline = isOnline
        }
    }
}
