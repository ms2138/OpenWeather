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

    init() {
        $city
            .dropFirst(1) // Drop the first value because it will perform a search for an empty city
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue(label: "LocationViewModel"))
            .sink(receiveValue: locations(for:))
            .store(in: &disposables)
    }

    func locations(for string: String) {
        weather.getLocations(forCity: city)
            .receive(on: DispatchQueue.main)
            .sink { (value) in
                switch value {
                    case .finished:
                        break
                    case .failure(_):
                        print("Request failed: \(value)")
                }
            } receiveValue: { (location) in
                self.dataSource = location
            }
            .store(in: &disposables)
    }
}
