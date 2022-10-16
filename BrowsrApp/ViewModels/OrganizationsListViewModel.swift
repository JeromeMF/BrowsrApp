//
//  OrganizationsListViewModel.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 13/10/2022.
//

import Foundation
import Combine
import SwiftUI

class OrganizationsListViewModel: ObservableObject {
    // MARK: - Properties
    private var cancellable: AnyCancellable?
    private var page: Int = 1
    private var totalPages = 0
    
    var favourites: [Item] = []
    
    @Published var organizations: [Item] = []

    init() {
        sortOrganization("followers")
    }
    
    // MARK: - Methods
    func getOrganizations() {
        print(page)
        cancellable = BrowsrLib().getOrganizations(page: page)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { data in
                self.organizations.append(contentsOf: data.items)
                self.totalPages = data.totalCount / 50
            })
        
    }
    
    // MARK: - Load more orgs
    func loadMoreOrganizations(index: Int, sortType: String) {
        let limitIndex = self.organizations.index(self.organizations.endIndex, offsetBy: -1)
        if limitIndex == index, (page + 1) <= totalPages {
            page += 1
            sortOrganization(sortType)
        }
    }
    
    // MARK: - Search for an organization by name
    func searchOrganization(_ name: String) {
        
        self.organizations.removeAll()
        print(name)
        cancellable = BrowsrLib().searchOrganization(orgName: name.lowercased())
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { data in
                self.organizations.append(contentsOf: data.items)
                print(data)
            })
    }
    
    // MARK: - Sort organizations
    func sortOrganization(_ sortType: String) {
        cancellable = BrowsrLib().sortOrganizations(page: page, sortType: sortType)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { data in
                self.organizations.append(contentsOf: data.items)
                self.totalPages = data.totalCount / 50
            })
    }
    
    func getFavourites() {
        clearOrganizations()
    }
    
    // MARK: - Clear organizations
    func clearOrganizations() {
        organizations.removeAll()
        page = 1
    }
    
    // MARK: - Save favourite
    func addToFavourite() {
        
    }
    
}
