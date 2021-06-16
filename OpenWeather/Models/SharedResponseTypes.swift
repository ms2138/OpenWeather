//
//  SharedResponseTypes.swift
//  OpenWeather
//
//  Created by mani on 2021-06-15.
//

import Foundation

// Weather description
enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// Geographic coordinates
struct Coord: Codable {
    let lat, lon: Double
}
