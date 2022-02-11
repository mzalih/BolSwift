//
//  HomeCoordinator.swift
//  Recepie
//
//  Created by Muhammed salih T A on 11/02/22.
//

import UIKit


protocol HomeCoordinatorDelegate: AnyObject {
    func onLogout()
}

class HomeCoordinator: Coordinator, DeepLinkable {
    
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
    
    func open(deepLink: DeepLink) {
        let id = (deepLink.arguments["id"] ?? "0")
        openItem(receipie: Receipie(color: "FFF000", id: Int(id) ?? 0, value: id))
    }
   
}
extension HomeCoordinator: ReceipieListViewControllerDelegate{
    func openRecipie(receipie:Receipie) {
        openItem(receipie:receipie)
    }
    
}

