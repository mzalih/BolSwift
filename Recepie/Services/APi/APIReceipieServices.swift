//
//  APIReceipieServices.swift
//  Recepie
//
//  Created by Muhammed salih T A on 28/01/22.
//

import UIKit
import Combine
import MNetwork

class APIReceipieServices: ReceipieService {
    
    init(session:URLSession) {
        MNetWork.addCustomSession(session)
    }
    
    func fetchList() -> AnyPublisher<[Receipie], Error> {
        
        MNetWork.request(url.product,
                          method: .get,
                          responseType: ListResponse.self)
            .tryMap { data in
                let items  = data.data?.map({ $0.toReceipie })
                return items ?? []
                }
            
      .eraseToAnyPublisher()
    }
    
    func fetchDetails() -> AnyPublisher<[Receipie], Error> {
        Future{
            promise in
            promise(.success([]))
        }.eraseToAnyPublisher()
    }
}
// MARK: - ListResponse
struct ListResponse: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [Product]?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }
}

// MARK: - Datum
struct Product: Codable {
    let id: Int?
    let name: String?
    let year: Int?
    let color, pantoneValue: String?

    enum CodingKeys: String, CodingKey {
        case id, name, year, color
        case pantoneValue = "pantone_value"
    }
}

extension Product {
    var toReceipie:Receipie{
        Receipie(color:  self.color ?? UIColor.random.hexString, id: self.id ?? 0, value: self.name ?? "")
    }
}

extension UIColor {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
