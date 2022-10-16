//
//  BrowsrLibError.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 13/10/2022.
//

import Foundation

// MARK: - Browsr Lib Error
enum BrowsrLibError: Error {
    case invalidUrl // Throw when an invalid url is passed
    case notFound // Throw when an expected resource is not found
    case unexpected(code: Int) // Throw in all other cases
}

// MARK: - Error types description
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
