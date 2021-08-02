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
    @Published private(set) var state = LoadingState.idle
    private var disposables = Set<AnyCancellable>()

    func weeklyWeather(forCoordinates coord: Coordinates) {
        self.state = .loading

        weather.getSevenDayWeatherForecast(forCoordinates: coord)
            .map { weather -> [WeatherRowViewModel] in
                let timeZone = weather.timezone
                return weather.forecast.map { forecast in
                    WeatherRowViewModel(forecast: forecast, timeZone: timeZone)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (value) in
                guard let weakSelf = self else { return }
                switch value {
                    case .finished:
                        break
                    case .failure(let error):
                        weakSelf.state = .failed(error)
                }
            } receiveValue: { [weak self] (forecast) in
                guard let weakSelf = self else { return }
                weakSelf.state = .loaded
                weakSelf.dataSource = forecast
            }
            .store(in: &disposables)
    }
}
