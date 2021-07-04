//
//  WeeklyWeatherViewModel.swift
//  OpenWeather
//
//  Created by mani on 2021-07-02.
//

import Foundation
import Combine

class WeeklyWeatherViewModel: ObservableObject {
    var weather = WeatherAPI()
    @Published var dataSource: [WeatherRowViewModel] = []
    private var disposables = Set<AnyCancellable>()

    func weeklyWeather(forCoordinates coord: Coordinates) {
        weather.getSevenDayWeatherForecast(forCoordinates: coord)
            .map {
                $0.forecast.map(WeatherRowViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink { (value) in
                switch value {
                    case .finished:
                        break
                    case .failure(_):
                        print("Request failed: \(value)")
                }
            } receiveValue: { (forecast) in
                self.dataSource = forecast
            }
            .store(in: &disposables)
    }
}
