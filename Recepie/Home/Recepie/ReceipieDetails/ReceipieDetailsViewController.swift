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
        return label
    }()
    override func loadView(){
        super.loadView()
        self.view.addSubview(label)
        label.constrainToParent()
        label.text = viewModel?.title
        view.backgroundColor = viewModel?.color
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

extension ReceipieDetailsViewController {
    class ViewModel: NSObject {
        private var item:Receipie
        
        var color:UIColor {
            item.color.asUIColor
        }
        
        
        var title:String {
            item.value
        }
        init(item:Receipie){
            self.item = item
        }
    }
}
