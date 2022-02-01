//
//  ReceipieDetailsViewModel.swift
//  Recepie
//
//  Created by Muhammed salih T A on 30/01/22.
//

import Foundation

extension ReceipieDetailsViewController {
    class ViewModel: NSObject {
        private var item:Receipie
        
        var color: String {
            item.color
        }
        
        
        var title:String {
            item.value
        }
        init(item:Receipie){
            self.item = item
        }
    }
}
