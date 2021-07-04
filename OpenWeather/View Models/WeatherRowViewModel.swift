//
//  WeatherRowViewModel.swift
//  OpenWeather
//
//  Created by mani on 2021-07-03.
//

import Foundation

struct WeatherRowViewModel: Identifiable {
    private let forecast: Forecast
    var id: UUID = UUID()

    var icons: String {
        switch forecast.weather[0].main {
            case .snow:
                return "🌨"
            case .clear:
                return "☀️"
            case .clouds:
                return "🌥"
            case .thunderstorm:
                return "⛈"
            case .drizzle:
                return "🌦"
            case .rain:
                return "🌧"
        }
    }

    var maxTemperature: String {
        return String(format: "%.1f", forecast.temp.max)
    }

    var minTemperature: String {
        return String(format: "%.1f", forecast.temp.min)
    }
}
