//
//  UIColorExtension.swift
//  bkalo
//
//  Created by Nguyễn Minh Tâm on 08/01/2024.
//

import UIKit

extension UIColor {
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0, red <= 255 else { return nil }
        guard green >= 0, green <= 255 else { return nil }
        guard blue >= 0, blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        let lowercaseHexString = hexString.lowercased()
        if lowercaseHexString.hasPrefix("0x") {
            string = lowercaseHexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hexValue >> 16) & 0xFF
        let green = (hexValue >> 8) & 0xFF
        let blue = hexValue & 0xFF
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
}

extension UIColor {
    static let royalBlue: UIColor = UIColor(hexString: "#2057C8")!
    static let brightRoyalBlue: UIColor = UIColor(hexString: "#2F68F7")!
    static let appleBlue: UIColor = UIColor(hexString: "#007AFF")!
    static let cornFlowerBlue: UIColor = UIColor(hexString: "#4396F4")!
    static let dodgerBlue: UIColor = UIColor(hexString: "#2196f3")!
    static let lightGrayishBlue: UIColor = UIColor(hexString: "#F2F5F7")!
    static let brightAzure: UIColor = UIColor(hexString: "#3B86F7")!
    static let azureBlue: UIColor = UIColor(hexString: "#275DE1")!
    static let iceBlue: UIColor = UIColor(hexString: "#F2F5F7")!
    
    static let athensGray: UIColor = UIColor(hexString: "#E9EDF0")!
    static let platinumGray: UIColor = UIColor(hexString: "#E4E4E4")!
    static let dimGray: UIColor = UIColor(hexString: "#6C6C6C")!
    static let midGray: UIColor = UIColor(hexString: "#8E8E8E")!
    static let lightSlateGray: UIColor = UIColor(hexString: "#CCD1D6")!
    static let lightGray: UIColor = UIColor(hexString: "#DEDEDE")!
    static let titanium: UIColor = UIColor(hexString: "#96999B")!
    static let mediumGray: UIColor = UIColor(hexString: "#878787")!
    static let darkGray: UIColor = UIColor(hexString: "#727272")!
    static let grayNickel: UIColor = UIColor(hexString: "#989898")!
    
    static let nearWhite: UIColor = UIColor(hexString: "#FEFEFE")!
    
    static let charcoalBrown: UIColor = UIColor(hexString: "#635D5C")!
    
    static let coralRed: UIColor = UIColor(hexString: "#F75B55")!
}
