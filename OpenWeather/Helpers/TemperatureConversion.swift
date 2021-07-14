//
//  TemperatureConversion.swift
//  OpenWeather
//
//  Created by mani on 2021-07-12.
//

import Foundation

func convert(temperature temp: Double, to unit: TemperatureUnit) -> Double {
    switch unit {
        case .celsius:
            return temp - 273.15
        case .fahrenheit:
            return (temp * 1.8) - 459.67
        default:
            return 0.0
    }
}
