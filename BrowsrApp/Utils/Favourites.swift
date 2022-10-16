//
//  Favourites.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 16/10/2022.
//

import Foundation
import SwiftUI

class Favourites: ObservableObject {
    
    // MARK: - Properties
    private var organizations: [Item] = []
    
    private let saveKey = "Favourites"
    
    let defaults = UserDefaults.standard
    
    // MARK: - Init()
    init() {
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey:  saveKey) as? Data {
            let taskData = try? decoder.decode([Item].self, from: data)
            self.organizations = taskData ?? []
        } else {
            self.organizations = []
        }
    }
    
    // MARK: - Methods
    func contains(_ organization: Item) -> Bool {
        return organizations.contains(organization)
    }
    
    func add(_ organization: Item) {
        objectWillChange.send()
        organizations.append(organization)
        save()
    }
    
    func remove(_ organization: Item) {
        objectWillChange.send()
        organizations.removeAll{ $0 == organization}
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(organizations) {
            defaults.set(encoded, forKey: saveKey)
        }
    }
}
