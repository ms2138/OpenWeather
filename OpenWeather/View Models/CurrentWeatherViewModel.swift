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
}
