//
//  BrowsrLibError.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 13/10/2022.
//

import Foundation

enum BrowsrLibError: Error {
    // Throw when an invalid url is passed
    case invalidUrl
    // Throw when an expected resource is not found
    case notFound
    // Throw in all other cases
    case unexpected(code: Int)
}

// For each error type return the appropriate description
extension BrowsrLibError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidUrl:
            return "The provided url is not valid."
        case .notFound:
            return "The specified item could not be found."
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}
