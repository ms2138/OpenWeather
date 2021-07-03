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
    case snow = "Snow"
    case thunderstorm = "Thunderstorm"
    case drizzle = "Drizzle"
}

// Geographic coordinates
struct Coord: Codable {
    let lat, lon: Double
}
