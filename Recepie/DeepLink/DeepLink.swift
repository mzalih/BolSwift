//
//  DeepLink.swift
//  Recepie
//
//  Created by Muhammed salih T A on 04/02/22.
//

import Foundation

protocol DeepLink {
    var arguments: [String: String] { get }
    var screenID: String { get }
    var type: DeepLinkType? { get }
}
struct PageDeepLink: DeepLink{
    var arguments: [String : String]
    var screenID: String
    var type: DeepLinkType?
    
    
}

enum DeepLinkType {
    case login
    case page
    case prompt
}

protocol DeepLinkable{
    func open(deepLink:DeepLink)
}

extension URL {
    public var queryParameters: [String: String] {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return [:] }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
