//
//  WeatherAPI.swift
//  OpenWeather
//
//  Created by mani on 2021-06-09.
//

import Foundation

class WeatherAPI {
    // APIEndpoint
    // Generate a base api endpoint to different OpenWeather API services
    // geoPath will allow access to location search
    // dataPath will allow access to various weather data
    // key is required and can be obtained by registering an account at the OpenWeather website
    struct APIEndpoint {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let geoPath = "/geo/1.0"
        static let dataPath = "/data/2.5"
        static let key = ""
    }

    // Create the base weather api components
    private func createWeatherAPIComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = APIEndpoint.scheme
        components.host = APIEndpoint.host

        return components
    }
}
