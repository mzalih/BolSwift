//
//  StoryboardInitializable.swift
//  Recepie
//
//  Created by Muhammed salih T A on 27/01/22.
//

import UIKit

protocol StoryboardInitializable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }
    static var storyboardIdentifier: String { get }
    static func initFromStoryboard() -> Self

    /**
     Dependency injection way of creating a view controller.
     Example Usage
     
         PaymentActivateViewController.makeFromStoryboard { coder in
             .init(viewModel: paymentsActivateViewModel,
                   paymentActivationEntry: paymentActivationEntry,
                   coder: coder)
         }
     */
    static func initFromStoryboard(creator: @escaping (NSCoder) -> Self?) -> Self
}

extension StoryboardInitializable {
    
    static var storyboardBundle: Bundle? {
        return nil
    }

    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static var storyboardName: String {
        return String(describing: self)
    }
    
    static func initFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)

        guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("No view controller with identifier \(storyboardIdentifier) in storyboard")
        }

        return viewController
    }

    static func initFromStoryboard(creator: @escaping (NSCoder) -> Self?) -> Self where Self: UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)

        let viewController = storyboard.instantiateViewController(identifier: storyboardIdentifier, creator: { (coder) in
            return creator(coder)
        })

        return viewController
    }

}
