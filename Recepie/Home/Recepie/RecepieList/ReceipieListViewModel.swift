//
//  ReceipieListViewModel.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import Foundation
import Combine

extension ReceipieListViewController{
    
    class ViewModel: NSObject {
        
        public private(set) var subsciptions: Set<AnyCancellable> = []
        var service: ReceipieService
        
        init(service: ReceipieService){
            self.service = service
            super.init()
        }
        @objc dynamic var loading = false
        var items = [Receipie]()
        
        func loadData(){
            if(loading){
                return
            }
            loading = true
            service.fetchList()
                .sink { (status) in
                    print(status)
                } receiveValue: { (data) in
                    self.items =  data
                    self.loading = false
                }
                .store(in: &subsciptions)
        }
        
        let reuseIdentifier = "UICollectionViewCell"
        // also enter this string as the cell identifier in the storyboard
        
    }
}
