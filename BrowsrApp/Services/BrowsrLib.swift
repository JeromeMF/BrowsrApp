//
//  BrowsrLib.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 13/10/2022.
//

import Foundation
import Combine

class BrowsrLib {
    
    // MARK: - Properties
    let BASE_URL_PAGES = "https://api.github.com/search/users?q=type:org&per_page=50&page="
    let BASE_URL_SEARCH = "https://api.github.com/search/users?q=org:"
//    let BASE_URL_SORT = "https://api.github.com/search/users?q=type:org&per_page=50&page="
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Get organizations method
    func getOrganizations(page: Int) -> AnyPublisher<UserModel, Error> {
        
        guard let url = URL(string: BASE_URL_PAGES + "\(page)") else {
            //        return Fail(error: NSError(domain: "Missing Feed URL", code: -10001, userInfo: nil)).eraseToAnyPublisher()
            return Fail(error: BrowsrLibError.invalidUrl).eraseToAnyPublisher()
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: UserModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    // MARK: - Search an organization
    func searchOrganization(orgName: String) -> AnyPublisher<UserModel, Error> {
        
        guard let url = URL(string: BASE_URL_SEARCH + "\(orgName)") else {
            return Fail(error: BrowsrLibError.invalidUrl).eraseToAnyPublisher()
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: UserModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    
    // MARK: - Sort organizations
    func sortOrganizations(page: Int, sortType: String) -> AnyPublisher<UserModel, Error> {
        
        guard let url = URL(string: BASE_URL_PAGES + "\(page)" + "&sort=\(sortType)") else {
            return Fail(error: BrowsrLibError.invalidUrl).eraseToAnyPublisher()
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: UserModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
}
