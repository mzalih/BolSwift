//
//  AppCoordinator.swift
//  Recepie
//
//  Created by Muhammed salih T A on 11/02/22.
//

import UIKit

class AppCoordinator: Coordinator, DeepLinkable {
    
    let rootViewController = UINavigationController()
    var activeCoordinators = ChildCoordinatorManager()
    var pendingDeepLink:DeepLink?
    func start() {
        startAuth()
    }
    
    func startAuth(){
        let activeCoordinator = AuthCoordinator(navigationController: rootViewController, delegate: self)
        activeCoordinator.start()
        self.activeCoordinators.add(coordinator: activeCoordinator)
    }
    
    func startHome(){
        self.activeCoordinators.remove(for: AuthCoordinator.identifier)
        let activeCoordinator = HomeCoordinator(navigationController: rootViewController, delegate: self)
        activeCoordinator.start()
        self.activeCoordinators.add(coordinator: activeCoordinator)
        
        // if any deeplink pending open it
        if let deepLink = pendingDeepLink {
            open(deepLink: deepLink)
        }
        
    }
    
    func open(deepLink: DeepLink) {
        if let deepLinlable = activeCoordinators.child(type: HomeCoordinator.self){
            deepLinlable.open(deepLink: deepLink)
            pendingDeepLink = nil
        }else{
            self.pendingDeepLink = deepLink
        }
    }
}

extension AppCoordinator : AuthCoordinatorDelegate {
    func onAuthSuccess() {
        startHome()
    }
}

extension AppCoordinator : HomeCoordinatorDelegate {
    func onLogout() {
        // shoud logout here
        startAuth()
    }
}
