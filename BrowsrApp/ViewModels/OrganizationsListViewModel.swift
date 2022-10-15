//
//  OrganizationsListViewModel.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 13/10/2022.
//

import Foundation
import Combine

class OrganizationsListViewModel: ObservableObject {
    // MARK: - Properties
    private var cancellable: AnyCancellable?
    private var page: Int = 1
    private var totalPages = 0
    
    @Published var organizations: [Item] = []

    init() {
        getOrganizations()
    }
    
    // MARK: - Methods
    func getOrganizations() {
        cancellable = BrowsrLib().getOrganizations(page: page)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { data in
                self.organizations.append(contentsOf: data.items)
                self.totalPages = data.totalCount / 30
                
                print("🚨 \(self.totalPages)")
                print("⚠️ \(self.organizations)")
            })
        
    }
    
    func loadMoreOrganizations(currentItem item: Item) {
//        let totalPages =

        let limitIndex = self.organizations.index(self.organizations.endIndex, offsetBy: -1)
        if limitIndex == item.id, (page + 1) <= totalPages {
            page += 1
            getOrganizations()
        }
    }
}
