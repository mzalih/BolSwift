//
//  AuthCoordinator.swift
//  Recepie
//
//  Created by Muhammed salih T A on 11/02/22.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func onAuthSuccess()
}

class AuthCoordinator: Coordinator {
    
    weak var delegate:AuthCoordinatorDelegate?
    let rootViewController: UINavigationController
    
    init(navigationController:UINavigationController, delegate:AuthCoordinatorDelegate) {
        rootViewController = navigationController
        self.delegate = delegate
    }
    
    func start() {
        let launchViewController =
            AuthViewController.initFromStoryboard(creator: { (coder) -> AuthViewController? in
                return AuthViewController(viewModel: AuthViewController.ViewModel(), delegate: self, coder: coder)
            })
        rootViewController.setNavigationBarHidden(true, animated: true)
        rootViewController.setViewControllers([launchViewController],animated: true)
    }
}
extension AuthCoordinator: AuthViewControllerDelegate{
    func onauthStatusChange(status: AuthState) {
        switch status {
        case .authenticatedUser:
            self.delegate?.onAuthSuccess()
        default:
            return
        }
    }
}
