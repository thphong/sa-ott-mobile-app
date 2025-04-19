//
//  Requests.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 14/4/25.
//

import UIKit

let defaultParams: [String: Any] = [:]

class Requests {
    let BASE_URL = URL(string: "https://api.sa-ott-zalo.click/")
    
    var token: String? {
        return AuthenManager.getSavedAuthModel()?.accessToken
    }
    
    var requiredParams: [String : Any] {
        let param = defaultParams
        return param
    }
}
