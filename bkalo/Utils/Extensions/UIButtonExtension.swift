//
//  UIButtonExtension.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 18/4/25.
//

import UIKit

extension UIButton {
    static func barButton(image: UIImage?, size: CGSize = CGSize(width: 24, height: 24)) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image?.withRenderingMode(.alwaysTemplate), for: [])
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return button
    }
}
