//
//  UIWindowExtension.swift
//  vnlook
//
//  Created by Nguyen Minh Tam on 11/01/2024.
//

import UIKit

extension UIWindow {
    static var isLandscape: Bool {
        guard #available(iOS 13, *) else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene else {
            return false
        }
        
        return windowScene.interfaceOrientation.isLandscape
    }
}
