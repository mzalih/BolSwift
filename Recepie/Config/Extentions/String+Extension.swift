//
//  String+Extension.swift
//  Recepie
//
//  Created by Muhammed salih T A on 30/01/22.
//

import Foundation
extension String {
    var toUrl: URL?{
        if let url = URL(string: self){
            return url
        }
        return nil
    }
}
