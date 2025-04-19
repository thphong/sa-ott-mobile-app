//
//  BaseModel.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 14/4/25.
//
import UIKit
import SwiftyJSON

class BaseModel: NSObject {
    
    var responseMessage: String = ""
    
    weak var sender: AnyObject?
    var responseJSON: JSON = JSON()

    required override init() {
        super.init()
    }
    
    init(_ data: JSON) {
        responseJSON = data
    }
}
