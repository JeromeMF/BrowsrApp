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
//    private var organizations: Set<Int>
    private var orgs: [Item] = []
    
    private let saveKey = "Favourites"
    
    let defaults = UserDefaults.standard
    
    // MARK: - Init()
    init() {
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey:  saveKey) as? Data {
            let taskData = try? decoder.decode([Item].self, from: data)
            self.orgs = taskData ?? []
        } else {
            self.orgs = []
        }
    }
    
    // MARK: - Methods
    func contains(_ organization: Item) -> Bool {
//        organizations.contains(organization.id)
        return orgs.contains(organization)
    }
    
    func add(_ organization: Item) {
        objectWillChange.send()
//        organizations.insert(organization.id)
        orgs.append(organization)
        save()
    }
    
    func remove(_ organization: Item) {
        objectWillChange.send()
//        organizations.remove(organization.id)
        
        if let index = orgs.firstIndex(of: organization) {
            orgs.remove(at: index)
        }
//        _ = orgs.filter {$0 == organization}
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(orgs) {//organizations) {
            defaults.set(encoded, forKey: saveKey)
        }
    }
}
