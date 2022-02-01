//
//  ReceipieListCellViewModel.swift
//  Recepie
//
//  Created by Muhammed salih T A on 30/01/22.
//

import Foundation

extension ReceipieListCell{
    class ViewModel{
        private let receipie:Receipie
        var title: String {
            receipie.value
        }
        var color: String{
            receipie.color
        }
        init(receipie:Receipie) {
            self.receipie = receipie
        }
    }
}
