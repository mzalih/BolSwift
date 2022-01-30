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

extension UIView {

    @discardableResult func constrainToParent(with insets: UIEdgeInsets = .zero) -> EdgeConstraints? {

        guard let parentView = superview else { return nil }

        translatesAutoresizingMaskIntoConstraints = false

        let top = topAnchor.constraint(equalTo: parentView.topAnchor, constant: insets.top)
        let bottom = parentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        let left = leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: insets.left)
        let right = parentView.rightAnchor.constraint(equalTo: rightAnchor, constant: insets.right)

        NSLayoutConstraint.activate([top, bottom, left, right])

        return EdgeConstraints(top: top, bottom: bottom, left: left, right: right)
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                    left: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    right: NSLayoutXAxisAnchor? = nil,
                    paddingTop: CGFloat = 0,
                    paddingLeft: CGFloat = 0,
                    paddingBottom: CGFloat = 0,
                    paddingRight: CGFloat = 0,
                    width: CGFloat? = nil,
                    height: CGFloat? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }
            
            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }
            
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
            
            if let right = right {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
            
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
        func center(inView view: UIView, yConstant: CGFloat? = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
        }
        
        func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            if let topAnchor = topAnchor {
                self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
            }
        }
        
        func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                     paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
            
            translatesAutoresizingMaskIntoConstraints = false
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
            
            if let left = leftAnchor {
                anchor(left: left, paddingLeft: paddingLeft)
            }
        }
        
        func setDimensions(width: CGFloat? = nil, height: CGFloat? = nil) {
            translatesAutoresizingMaskIntoConstraints = false
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }

        
        func fillSuperview() {
            translatesAutoresizingMaskIntoConstraints = false
            guard let view = superview else { return }
            anchor(top: view.topAnchor, left: view.leftAnchor,
                   bottom: view.bottomAnchor, right: view.rightAnchor)
        }
    
}

struct EdgeConstraints {

    var top: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    var left: NSLayoutConstraint?
    var right: NSLayoutConstraint?
    
    func activateAll() {
        if let top = top {
            NSLayoutConstraint.activate([
                top
            ])
        }

        if let bottom = bottom {
            NSLayoutConstraint.activate([
                bottom
            ])
        }
        
        if let left = left {
            NSLayoutConstraint.activate([
                left
            ])
        }
        
        if let right = right {
            NSLayoutConstraint.activate([
                right
            ])
        }
    }
}
