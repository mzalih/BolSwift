//
//  ReceipieDetailsViewController.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import UIKit
import Combine

class ReceipieDetailsViewController: UIViewController {

    var viewModel:ViewModel?
    var label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.accessibilityIdentifier = label.theClassName
        return label
    }()
    
    override func loadView(){
        super.loadView()
        self.view.addSubview(label)
        label.constrainToParent()
        label.text = viewModel?.title
        view.backgroundColor = viewModel?.color.asUIColor
    }
    
    convenience init(viewModel:ViewModel) {
        self.init()
        self.viewModel = viewModel
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
