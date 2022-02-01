//
//  ReceipieService.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import UIKit
import Combine

protocol ReceipieService{
   func fetchList() -> AnyPublisher<[Receipie], Error>
   func fetchDetails() -> AnyPublisher<[Receipie], Error>
}
