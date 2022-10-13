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
    
    @Published var organization: [UserModel] = []
    
    // MARK: - Methods
    
    func getOrganizations() {
        
    }
}
