//
//  ReceipieDetailsViewController.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import UIKit

class ReceipieDetailsViewController: UIViewController {

    var viewModel:ViewModel?
    
    convenience init(viewModel:ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.viewModel?.color
        // Do any additional setup after loading the view.
    }

}

extension ReceipieDetailsViewController {
    class ViewModel {
        private var item:Receipie
        
        var color:UIColor {
            item.color.asUIColor
        }
        
        init(item:Receipie){
            self.item = item
        }
    }
}
