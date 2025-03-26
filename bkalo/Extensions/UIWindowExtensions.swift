//
//  UIWindowExtensions.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 17/3/25.
//

import UIKit

extension UIWindow {
    func clearAllRootVC() {
        guard let rootViewController = rootViewController else { return }
        
        rootViewController.dismiss(animated: false) {
            self.rootViewController = nil
        }
        
        rootViewController.navigationController?.popToRootViewController(animated: false)
    }
}
