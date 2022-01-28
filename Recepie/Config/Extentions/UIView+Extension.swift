//
//  UIViewController+Extension.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import UIKit

extension UIView {
    
    func showLoader( _ message: String? = "Please wait..." ) {
        self.endEditing(true)
        self.isUserInteractionEnabled = false
        self.makeToastActivity(.center)
    }
    
    func hideLoader(){
        self.isUserInteractionEnabled = true
        self.hideToastActivity()
    }
}
