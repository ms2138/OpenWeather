//
//  WeatherAPI.swift
//  OpenWeather
//
//  Created by mani on 2021-06-09.
//

import Foundation
import Combine

class WeatherAPI {
    private let session: APISession

    init(session: APISession = APISessionProvider()) {
        self.session = session
    }

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

    // Create daily forecast endpoint using longitude and latitude coordinates
    func createDailyForecastEndpoint(forCoordinates coord: Coordinates, unit: TemperatureUnit) -> URLComponents {
        var components = createWeatherAPIComponents()
        components.path = APIEndpoint.dataPath + "/weather"

        components.queryItems = [
            URLQueryItem(name: "lat", value: String(coord.latitude)),
            URLQueryItem(name: "lon", value: String(coord.longitude)),
            URLQueryItem(name: "units", value: unit.rawValue),
            URLQueryItem(name: "appid", value: APIEndpoint.key)
        ]

        return components
    }

    // Create five day forecast endpoint using longitude and latitude coordinates
    func createFiveDayForecastEndpoint(forCoordinates coord: Coordinates, unit: TemperatureUnit) -> URLComponents {
        var components = createWeatherAPIComponents()
        components.path = APIEndpoint.dataPath + "/forecast"

        components.queryItems = [
            URLQueryItem(name: "lat", value: String(coord.latitude)),
            URLQueryItem(name: "lon", value: String(coord.longitude)),
            URLQueryItem(name: "units", value: unit.rawValue),
            URLQueryItem(name: "appid", value: APIEndpoint.key)
        ]

        return components
    }

    // Create seven day forecast endpoint using longitude and latitude coordinates
    func createSevenDayForecastEndpoint(forCoordinates coord: Coordinates, unit: TemperatureUnit) -> URLComponents {
        var components = createWeatherAPIComponents()
        components.path = APIEndpoint.dataPath + "/onecall"

        components.queryItems = [
            URLQueryItem(name: "lat", value: String(coord.latitude)),
            URLQueryItem(name: "lon", value: String(coord.longitude)),
            URLQueryItem(name: "exclude", value: "current,alerts,hourly,minutely"),
            URLQueryItem(name: "units", value: unit.rawValue),
            URLQueryItem(name: "appid", value: APIEndpoint.key)
        ]

        return components
    }

    // Create location search endpoint using a city name.  Limit parameter controls how many cities you will
    // see with the same name.
    func createLocationsEndpoint(forCity city: String, limit: String = "20") -> URLComponents {
        var components = createWeatherAPIComponents()
        components.path = APIEndpoint.geoPath + "/direct"

        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "limit", value: limit),
            URLQueryItem(name: "appid", value: APIEndpoint.key)
        ]

        return components
    }
}

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

// OpenWeather TemperatureUnit
// Returned temperature can be in:
// metric will result in Celsius
// imperial will result in Fahrenheit
// standard will result in Kelvin
enum TemperatureUnit: String {
    case celsius = "metric",
         fahrenheit = "imperial",
         kelvin = "standard"
}

extension WeatherAPI: WeatherFetchable {
    func getFiveDayWeatherForecast(forCoordinates coord: Coordinates, unit: TemperatureUnit = .kelvin) -> AnyPublisher<FiveDayWeatherForecast, APIError> {
        return session.performRequest(createFiveDayForecastEndpoint(forCoordinates: coord, unit: unit))
    }

    func getSevenDayWeatherForecast(forCoordinates coord: Coordinates,
                                    unit: TemperatureUnit = .kelvin) -> AnyPublisher<SevenDayWeatherForecast, APIError> {
        return session.performRequest(createSevenDayForecastEndpoint(forCoordinates: coord, unit: unit))
    }

    func getCurrentWeatherForecast(forCoordinates coord: Coordinates,
                                   unit: TemperatureUnit = .kelvin) -> AnyPublisher<CurrentWeatherForecast, APIError> {
        return session.performRequest(createDailyForecastEndpoint(forCoordinates: coord, unit: unit))
    }

    func getLocations(forCity city: String) -> AnyPublisher<Location, APIError> {
        return session.performRequest(createLocationsEndpoint(forCity: city))
    }
}
