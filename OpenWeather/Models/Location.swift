//
//  Location.swift
//  OpenWeather
//
//  Created by mani on 2021-06-15.
//

import Foundation

struct LocationElement: Codable, Identifiable, Hashable {
    let id = UUID()
    let name: String
    let lat, lon: Double
    let country: String
    let state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case lat, lon, country, state
    }
}

typealias Location = [LocationElement]
