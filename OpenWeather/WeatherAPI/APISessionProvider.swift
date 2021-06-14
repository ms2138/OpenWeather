//
//  APISessionProvider.swift
//  OpenWeather
//
//  Created by mani on 2021-06-13.
//

import Foundation
import Combine

protocol APISession {
    func performRequest<T: Decodable>(_ components: URLComponents) -> AnyPublisher<T, APIError>
}

struct APISessionProvider: APISession {
    func performRequest<T>(_ components: URLComponents) -> AnyPublisher<T, APIError> where T : Decodable {
        guard let url = components.url else {
            let error = APIError.network(description: "Failed to create URL from components")
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}
