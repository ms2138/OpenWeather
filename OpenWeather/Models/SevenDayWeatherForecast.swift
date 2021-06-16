//
//  SevenDayWeatherForecast.swift
//  OpenWeather
//
//  Created by mani on 2021-06-14.
//

import Foundation

struct SevenDayWeatherForecast: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let forecast: [Forecast]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case forecast = "daily"
    }
}

struct Forecast: Codable {
    let date, sunrise, sunset, moonrise, moonset: Date
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, rain, uvi
    }

}

struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
