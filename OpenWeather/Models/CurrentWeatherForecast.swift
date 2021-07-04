//
//  CurrentWeatherForecast.swift
//  OpenWeather
//
//  Created by mani on 2021-06-15.
//

import Foundation

struct CurrentWeatherForecast: Decodable, Identifiable {
    let id: Int
    let name: String
    let coord: Coord
    let weather: [Weather]
    let main: Main

    struct Main: Codable {
        let temperature: Double
        let humidity: Int
        let maxTemperature: Double
        let minTemperature: Double

        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case humidity
            case maxTemperature = "temp_max"
            case minTemperature = "temp_min"
        }
    }

    struct Weather: Codable {
        let id: Int
        let main, weatherDescription, icon: String

        enum CodingKeys: String, CodingKey {
            case id, main
            case weatherDescription = "description"
            case icon
        }
    }
}
