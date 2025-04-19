//
//  NavigationController.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 29/3/25.
//

import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .cornFlowerBlue
            appearance.shadowColor = .cornFlowerBlue
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
}
