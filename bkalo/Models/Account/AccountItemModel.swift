//
//  AccountItemModel.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 18/2/25.
//

import UIKit

final class AccountItemModel {
    private var _icon: String
    private var _title: String
    private var _isMore: Bool
    
    var icon: String {
        get { return _icon }
        set { _icon = newValue }
    }
    
    var title: String {
        get { return _title }
        set { _title = newValue }
    }
    
    var isMore: Bool {
        get { return _isMore }
        set { _isMore = newValue }
    }
    
    init(icon: String, title: String, isMore: Bool) {
        self._icon = icon
        self._title = title
        self._isMore = isMore
    }
}

