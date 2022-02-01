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
        
        var service: ReceipieService
        init(service: ReceipieService){
            self.service = service
            super.init()
        }
        @objc dynamic var loading = false
        var items = [Receipie]()
        
        func loadData() -> AnyPublisher<Bool, Error>{
            if(loading){
                return Future {
                    promoise in
                    promoise(.success(false))
                }.eraseToAnyPublisher()
            }
            loading = true
            return service.fetchList().tryMap{ data -> Bool in
                self.items =  data
                self.loading = false
                return true
            }.eraseToAnyPublisher()
        }
        
        let reuseIdentifier = "ReceipieListCell-"
        // also enter this string as the cell identifier in the storyboard
        
    }
}
