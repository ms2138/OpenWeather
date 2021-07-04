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
}
