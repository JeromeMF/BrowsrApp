//
//  BrowsrLib.swift
//  BrowsrApp
//
//  Created by Jérôme Figueiredo on 13/10/2022.
//

import Foundation
import Combine

// MARK: - Properties
let BASE_URL = "https://api.github.com/search/users?q=type:org"

private var cancellable: AnyCancellable?

// MARK: - Get organizations method
func getOrganizations() -> AnyPublisher<UserModel, Error> {
    
    guard let url = URL(string: BASE_URL) else {
        //        return Fail(error: NSError(domain: "Missing Feed URL", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        return Fail(error: BrowsrLibError.invalidUrl).eraseToAnyPublisher()
    }
    
    let publisher = URLSession.shared.dataTaskPublisher(for: url)
//        .receive(on: DispatchQueue.main)
        .map(\.data)
        .decode(type: UserModel.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    
    return publisher
}

//enum FailureReason : Error {
//     case sessionFailed(error: URLError)
//     case decodingFailed
//     case other(Error)
// }
//
// static func request<SomeDecodable: Decodable>(url: URL) -> AnyPublisher<SomeDecodable, FailureReason> {
//   return URLSession.shared.dataTaskPublisher(for: url)
//     .map(\.data)
//     .decode(type: SomeDecodable.self, decoder: JSONDecoder())
//     .mapError({ error in
//       switch error {
//       case is Swift.DecodingError:
//         return .decodingFailed
//       case let urlError as URLError:
//         return .sessionFailed(error: urlError)
//       default:
//         return .other(error)
//       }
//     })
//     .eraseToAnyPublisher()
// }