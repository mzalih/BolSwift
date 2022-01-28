//
//  PullToReloadable.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import UIKit

protocol PullToReloadable {
   // func reload()
}

extension PullToReloadable{
    func addRefresh(target: Any?, scrollView: UIScrollView? , _ action: Selector, refreshControl: UIRefreshControl = UIRefreshControl()) {
        if let scrollView = scrollView {
            let message = "pull down to refresh"
            let neMessage  = NSMutableAttributedString(string: message)
          //  neMessage.setFont(message, withFont: GFont.regular(14))
            refreshControl.attributedTitle = neMessage
            refreshControl.addTarget(target, action:action, for: UIControl.Event.valueChanged)
            scrollView.addSubview(refreshControl)
        }
    }
}
