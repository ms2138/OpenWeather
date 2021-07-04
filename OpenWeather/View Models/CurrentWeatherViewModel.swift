//
//  CurrentWeatherViewModel.swift
//  OpenWeather
//
//  Created by mani on 2021-07-03.
//

import Foundation
import Combine

class CurrentWeatherViewModel: ObservableObject {
    var weather = WeatherAPI()
    @Published var dataSource = [CurrentWeatherForecast]()
    private var disposables = Set<AnyCancellable>()

    func currentWeather(forCoordinates coord: Coordinates) {
        weather.getCurrentWeatherForecast(forCoordinates: coord)
            .receive(on: DispatchQueue.main)
            .sink { (value) in
                switch value {
                    case .failure(_):
                        print("Request failed: \(value)")
                    case .finished:
                        break
                }
            } receiveValue: { (forecast) in
                self.dataSource.append(forecast)
            }
            .store(in: &disposables)
    }
}
