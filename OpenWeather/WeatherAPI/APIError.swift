//
//  APIError.swift
//  OpenWeather
//
//  Created by mani on 2021-06-13.
//

import Foundation

enum APIError: Error {
    case parsing(description: String)
    case network(description: String)
}
