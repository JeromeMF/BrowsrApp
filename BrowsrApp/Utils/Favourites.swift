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
    private var organizations: Set<Int>
    
    private let saveKey = "Favourites"
    
    let defaults = UserDefaults.standard
    
    // MARK: - Init()
    init() {
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey:  saveKey) as? Data {
            let taskData = try? decoder.decode(Set<Int>.self, from: data)
            self.organizations = taskData ?? []
        } else {
            self.organizations = []
        }
    }
    
    // MARK: - Methods
    func contains(_ organization: Item) -> Bool {
        organizations.contains(organization.id)
    }
    
    func add(_ organization: Item) {
        objectWillChange.send()
        organizations.insert(organization.id)
        save()
    }
    
    func remove(_ organization: Item) {
        objectWillChange.send()
        organizations.remove(organization.id)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(organizations) {
            defaults.set(encoded, forKey: saveKey)
        }
    }
}
