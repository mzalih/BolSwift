//
//  CachedRecepieService.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import Foundation
import Combine
import UIKit

class CachedRecepieService: ReceipieService {
    func fetchList() -> AnyPublisher<[Receipie], Error> {
        Future{
            promise in
            
            var options = [Receipie]()
            for i in 0...100 {
                options.append(Receipie(color:  UIColor.random.hexString, id: i, value: String(i)))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(.success(options))
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchDetails() -> AnyPublisher<[Receipie], Error> {
        Future{
            promise in
            promise(.success([]))
        }.eraseToAnyPublisher()
    }
}
