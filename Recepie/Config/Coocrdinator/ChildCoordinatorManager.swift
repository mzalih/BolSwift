//
//  ChildCoordinatorManager.swift
//  Recepie
//
//  Created by Muhammed salih T A on 11/02/22.
//

import Foundation

struct ChildCoordinatorManager {
    private(set) var children: [String: Any]

    init() {
        children = [:]
    }

    func child<T>(for key: String) -> T? where T: Coordinator {
        return children[key] as? T
    }
    
    func child<T>(type: T.Type) -> T? where T: Coordinator {
        return children[type.identifier] as? T
    }

    subscript<T>(key: String) -> T? where T: Coordinator {
        return child(for: key)
    }

    mutating func add<T>(coordinator: T) where T: Coordinator {
        children[coordinator.identifier] = coordinator
    }

    mutating func remove(for key: String) {
        children.removeValue(forKey: key)
    }

    mutating func removeAll() {
        children.removeAll()
    }
}
