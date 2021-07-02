//
//  LocationViewModel.swift
//  OpenWeather
//
//  Created by mani on 2021-06-27.
//

import Foundation
import Combine

class LocationViewModel: ObservableObject {
    var weather = WeatherAPI()
    @Published var city: String = ""
    @Published var dataSource: [LocationElement] = []
    private var disposables = Set<AnyCancellable>()

    func locations(for string: String) {
        weather.getLocations(forCity: city)
            .receive(on: DispatchQueue.main)
            .sink { (value) in
            } receiveValue: { (location) in
                self.dataSource = location
            }
            .store(in: &disposables)
    }
}
