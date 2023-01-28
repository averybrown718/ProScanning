//
//  Extension.swift
//  TextRecognition
//
//  Created by iOS Dev on 10/31/22.
//

import Foundation
import UIKit


extension Date {
    
    var toDayStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM YY"
        return formatter.string(from: self)
    }
    
    var toStr: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, dd MM YY"
        return formatter.string(from: self)
    }
}

extension String {
    
    var toDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, dd MM YY"
        return formatter.date(from: self)
    }
}

extension UIColor {
    
    static func hexStringToUIColor (hex:String, alpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}


