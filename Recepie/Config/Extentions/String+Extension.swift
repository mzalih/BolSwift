//
//  String+Extension.swift
//  Recepie
//
//  Created by Muhammed salih T A on 30/01/22.
//

import UIKit

extension String {
    var toUrl: URL?{
        if let url = URL(string: self){
            return url
        }
        return nil
    }
}

extension String {
    var asUIColor: UIColor{
        let hex = self;
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
