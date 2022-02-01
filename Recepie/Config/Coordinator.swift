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

class AppCoordinator: Coordinator {
    let rootViewController = UINavigationController()
    var activeCoordinators = ChildCoordinatorManager()
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

protocol HomeCoordinatorDelegate: AnyObject {
    func onLogout()
}

class HomeCoordinator: Coordinator {
    
    weak var delegate:HomeCoordinatorDelegate?
    let rootViewController: UINavigationController
    
    init(navigationController:UINavigationController, delegate:HomeCoordinatorDelegate) {
        rootViewController = navigationController
        self.delegate = delegate
    }
    
    func start() {
        let launchViewController =
            ReceipieListViewController.initFromStoryboard(creator: { (coder) -> ReceipieListViewController? in
                return ReceipieListViewController(viewModel: ReceipieListViewController.ViewModel(service: APIReceipieServices(session: .instance(APIReceipieServices.self))), delegate: self, coder: coder)
            })
        rootViewController.setNavigationBarHidden(false, animated: true)
        rootViewController.setViewControllers([launchViewController],animated: true)
    }
    
    func openItem(receipie:Receipie){
        let detailsView = ReceipieDetailsViewController(viewModel: ReceipieDetailsViewController.ViewModel(item: receipie))
        rootViewController.pushViewController(detailsView, animated: true)
    }
}
extension HomeCoordinator: ReceipieListViewControllerDelegate{
    func openRecipie(receipie:Receipie) {
        openItem(receipie:receipie)
    }
    
}


struct ChildCoordinatorManager {
    private(set) var children: [String: Any]

    init() {
        children = [:]
    }

    func child<T>(for key: String) -> T? where T: Coordinator {
        return children[key] as? T
    }
    
    func child<T>(type: T.Type) -> T? where T: Coordinator {
        return children[type.identifier] as? T
    }

    subscript<T>(key: String) -> T? where T: Coordinator {
        return child(for: key)
    }

    mutating func add<T>(coordinator: T) where T: Coordinator {
        children[coordinator.identifier] = coordinator
    }

    mutating func remove(for key: String) {
        children.removeValue(forKey: key)
    }

    mutating func removeAll() {
        children.removeAll()
    }
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
