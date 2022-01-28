//
//  ViewController.swift
//  Recepie
//
//  Created by Muhammed salih T A on 27/01/22.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func onauthStatusChange(status:AuthState)
}
enum AuthState{
    case authenticatedUser
    case unknownUser
}

class AuthViewController: UIViewController, StoryboardInitializable {
    
    static var storyboardName: String = "Main"
    weak var delegate:AuthViewControllerDelegate?
    let viewModel:ViewModel
    
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
        setupView()
    }
    
    func setupView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.delegate?.onauthStatusChange(status: .authenticatedUser);
        }
    }


}
extension AuthViewController{
    
    class ViewModel {
        
        
        
    }
}
