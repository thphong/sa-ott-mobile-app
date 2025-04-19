//
//  DictionaryExtension.swift
//  bkalo
//
//  Created by Nguyen Minh Tam on 18/4/25.
//

import UIKit

enum BooleanEncoding {
    /// Encode `true` as `1` and `false` as `0`.
    case numeric
    /// Encode `true` and `false` as string literals.
    case literal

    func encode(value: Bool) -> String {
        switch self {
        case .numeric:
            return value ? "1" : "0"
        case .literal:
            return value ? "true" : "false"
        }
    }
}

extension Dictionary {
    func percentEscaped(boolEncoding: BooleanEncoding = .numeric) -> String {
        return map { (key, value) in
            let escapedKey = escape("\(key)")
            let escapedValue = escape(encode(value: value, boolEncoding: boolEncoding))
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
    
    /// Creates a percent-escaped string following RFC 3986 for a query string key or value.
    ///
    /// - Parameter string: `String` to be percent-escaped.
    ///
    /// - Returns:          The percent-escaped `String`.
    private func escape(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? string
    }
    
    private func encode(value: Any, boolEncoding: BooleanEncoding) -> String {
        switch value {
        case let bool as Bool:
            return boolEncoding.encode(value: bool)
        default:
            return "\(value)"
        }
    }
    
    func toJSON() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []),
              let json = String(data: data, encoding: .utf8) else {
            return ""
        }
        
        return json
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

