//
//  BrowsrLibTest.swift
//  BrowsrAppTests
//
//  Created by Jérôme Figueiredo on 17/10/2022.
//

import Foundation
import XCTest
import Combine
@testable import BrowsrApp

class ApiServiceTest: XCTestCase {
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    // MARK: - Test Get Organizations
    func testOrganizations() {
        let expectation = self.expectation(description: "Fetch GitHub organizations - page 1")
        var error: Error?
//        var id: Int = 0
        var name: String = ""
        
        BrowsrLib().getOrganizations(page: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                
                expectation.fulfill()
            }, receiveValue: { value in
                print(value)
                name = value.items.first?.login ?? ""
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNil(error)
        XCTAssertEqual(name, "microsoft") // For followers microsoft comes first
        XCTAssertFalse(name == "google") // Check is organization is something else other than microsoft
    }
    
    // MARK: - Test Search Organizations
    func testSearchOrganization() {
        let expectation = self.expectation(description: "Search Google by name and expects google")
        var error: Error?
//        var id: Int = 0
        var name: String = ""
        
        BrowsrLib().searchOrganization(orgName: "google")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                
                expectation.fulfill()
            }, receiveValue: { value in
                print(value)
                name = value.items.first?.login ?? ""
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5)
        
        XCTAssertNil(error)
        XCTAssertEqual(name, "google") // Should return google
        XCTAssertNotEqual(name, "microsoft") // Name is something else than google
        XCTAssertFalse(name != "google") // Name is not google
    }
    
}
