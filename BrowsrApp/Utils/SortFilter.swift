//
//  SortFilter.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 16/10/2022.
//

import Foundation

// MARK: - Sorting types
enum SortingType: String {
    case followers
    case repositories
    case joined
}

// MARK: - Error types description
extension SortingType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .followers:
            return "followers"
        case .repositories:
            return "repositories"
        case .joined:
            return "joined"
        }
    }
}
