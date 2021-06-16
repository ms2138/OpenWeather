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
}
