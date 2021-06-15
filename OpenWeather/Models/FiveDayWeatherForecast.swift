//
//  FiveDayWeatherForecast.swift
//  OpenWeather
//
//  Created by mani on 2021-06-14.
//

import Foundation

struct FiveDayWeatherForecast: Codable {
    let list: [Item]
    let city: City

    struct Item: Codable {
        let date: Date
        let main: MainClass
        let weather: [Weather]

        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }

    struct City: Codable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population, timezone, sunrise, sunset: Int
    }

    struct Coord: Codable {
        let lat, lon: Double
    }

    struct MainClass: Codable {
        let temp: Double
    }

    struct Weather: Codable {
        let main: MainEnum
        let weatherDescription: String

        enum CodingKeys: String, CodingKey {
            case main
            case weatherDescription = "description"
        }
    }

    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
}
