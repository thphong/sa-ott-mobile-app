//
//  UIFontExtension.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

extension UIFont {
    static func interRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: size)!
    }
    
    static func interBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Bold", size: size)!
    }
    
    static func interItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Italic", size: size)!
    }
    
    static func interMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Medium", size: size)!
    }
}
