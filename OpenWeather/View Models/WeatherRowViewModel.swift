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

    var humidity: String {
        return String(format: "%d%%", forecast.humidity)
    }

    var precipitation: String {
        return String(format: "%.0f%%", forecast.pop)
    }

    var sunrise: String {
        return timeFormatter.string(from: forecast.sunrise)
    }

    var sunset: String {
        return timeFormatter.string(from: forecast.sunset)
    }

    var feelsLike: String {
        return String(format: "%.1f", forecast.feelsLike.day)
    }

    var uvIndex: String {
        return String(format: "%d", forecast.uvi)
    }

    init(forecast: Forecast) {
        self.forecast = forecast
    }
}
