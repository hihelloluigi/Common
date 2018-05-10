//
//  String+XT.swift
//  ArubaCommon
//
//  Created by Luigi Aiello on 17/01/17.
//  Copyright © 2017 Luigi Aiello srl. All rights reserved.
//

import UIKit

extension String {
    /**
        Initializes an image from a string.

        - Returns: an instance of UIImage for the image named `self` and contained in the main bundle.
     */
    public var image: UIImage? {
        return UIImage(named: self)
    }
    
    
    
    public var localized: String {
        return self.localized(bundle: Bundle.main)
    }
    
    public func localized(bundleClass: Swift.AnyClass) -> String {
        return self.localized(bundle: Bundle(for: bundleClass))
    }
    
    func localized(withTableNamed tableName: String? = nil, bundle: Bundle = Bundle.main, comment: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "", comment: comment)
    }
    
    /**
     Create a date from string.
     
     - Parameter format:  A string that rappresent the date format (ex: dd/mm/yyyy)
     - Parameter locale: Default value is Locale.current
     - Parameter timeZone: Default value is TimeZone.current

     - Returns: an instance of Date localizzate.
     */
    public func date(_ format: String, locale: Locale = Locale.current, timeZone: TimeZone = TimeZone.current) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        return dateFormatter.date(from: self)
    }
    
    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    public func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    public func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    public func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    public func substring(start: Int? = 0, length: Int) -> String {
        let s = start ?? 0
        return String(self[index(from: s)..<index(from: s+length)])
    }
    
    public subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    /**
     Convert string to boolean value.
     
     - Returns: a nullable boolean value.
     */
    public func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    public var firstUppercased: String {
        guard let first = first else {
            return ""
        }

        return String(first).uppercased() + dropFirst()
    }
    
    /**
     Remove whitespace from string
     
     - Returns: a string without whitespace.
     */
    public func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    /**
     Add percent to url to obtain a correct url encoded
     
     - Returns: a nullable string with url encoded in correct way
     */
    public var urlEncode: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    public func isValidPolicyOID() -> Bool {
        let pattern = "(\\d+\\.\\d+(\\.\\d+)*)?"
        let stringRange = self.startIndex..<self.endIndex
        let range = self.range(of: pattern, options: .regularExpression)
        return stringRange == range
    }
}

infix operator ~>
/**
 Returns the localized message for `localizationKey` in `tableName`;
 this function searches the strings table in the main bundle.

 - parameter tableName: the .strings file name that includes the translation of `localizationKey`
 - parameter localizationKey: the key for which a localized string should exist in file `tableName`.strings
 
 - returns: the localization for `localizationKey` in `tableName`
 */
public func ~> (tableName: String, localizationKey: String) -> String {
    return localizationKey.localized(withTableNamed: tableName)
}
