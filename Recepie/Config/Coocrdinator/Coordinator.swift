//
//  Coordinator.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import UIKit

protocol Coordinator {
    associatedtype RootViewController : UIViewController
    var rootViewController: RootViewController { get }
    func start()
}

extension Coordinator {
    var identifier: String {
        return Self.identifier
    }

    static var identifier: String {
        guard let identifier = String(describing: Self.self).components(separatedBy: ".").last else {
            assertionFailure("Something went wrong!")
            return ""
        }

        return identifier
    }

    func start() {}
}
