//
//  NSObject+Extension.swift
//  Recepie
//
//  Created by Muhammed salih T A on 30/01/22.
//

import Foundation

extension NSObject {
    var theClassName: String {
        return NSStringFromClass(type(of: self))
    }
}
