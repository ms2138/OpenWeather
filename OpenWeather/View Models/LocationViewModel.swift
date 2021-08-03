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
    @Published private(set) var state = LoadingState.idle
    private var disposables = Set<AnyCancellable>()

    init() {
        $city
            .dropFirst(1) // Drop the first value because it will perform a search for an empty city
            .debounce(for: .seconds(0.8), scheduler: DispatchQueue(label: "LocationViewModel"))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] city in
                if !city.isEmpty && city.trimmingCharacters(in: .whitespaces) != "" {
                    self?.locations(for: city)
                } else {
                    self?.state = .idle
                }
            })
            .store(in: &disposables)
    }

    func locations(for string: String) {
        self.state = .loading
        
        weather.getLocations(forCity: city)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.state = .failed(error)
                }
            } receiveValue: { [weak self] location in
                self?.state = .loaded
                self?.dataSource = location
            }
            .store(in: &disposables)
    }
}
