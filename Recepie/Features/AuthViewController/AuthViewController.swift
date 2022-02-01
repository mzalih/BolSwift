//
//  ViewController.swift
//  Recepie
//
//  Created by Muhammed salih T A on 27/01/22.
//

import UIKit
import Combine

protocol AuthViewControllerDelegate: AnyObject {
    func onauthStatusChange(status:AuthState)
}

class AuthViewController: UIViewController, StoryboardInitializable {
    
    static var storyboardName: String = "Main"
    weak var delegate:AuthViewControllerDelegate?
    let viewModel:ViewModel
    var cancellableRequest: Cancellable?
   
    init?(viewModel:ViewModel, delegate:AuthViewControllerDelegate, coder: NSCoder){
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData(){
        
        cancellableRequest =
            viewModel.isUserLoggedIn()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (status) in }, receiveValue: { (response) in
                self.delegate?.onauthStatusChange(status: response);
            })
    }


}
