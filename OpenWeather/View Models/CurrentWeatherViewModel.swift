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
    private static var savedFileURL: URL {
        return FileManager.default.documentsDirectory.appendingPathComponent("locations.json")
    }

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
            } receiveValue: { [weak self] (forecast) in
                guard let weakSelf = self else { return }
                weakSelf.dataSource.insert(forecast, at: weakSelf.dataSource.startIndex)
            }
            .store(in: &disposables)
    }

    func refresh(forecast: CurrentWeatherForecast) {
        weather.getCurrentWeatherForecast(forCoordinates: Coordinates(latitude: forecast.coord.lat,
                                                                      longitude: forecast.coord.lon))
            .receive(on: DispatchQueue.main)
            .sink { (value) in
                switch value {
                    case .failure(_):
                        print("Request failed: \(value)")
                    case .finished:
                        break
                }
            } receiveValue: { [weak self] (forecast) in
                if let index = self?.dataSource.firstIndex(where: { $0.id == forecast.id }) {
                    self?.dataSource[index] = forecast
                }
            }
            .store(in: &disposables)
    }
}

extension CurrentWeatherViewModel {
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let savedLocations = try? JSONDataManager<CurrentWeatherForecast>().read(from: Self.savedFileURL) else {
                return
            }

            DispatchQueue.main.async {
                for location in savedLocations {
                    self?.dataSource.append(location)
                    self?.refresh(forecast: location)
                }
            }
        }
    }

    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let items = self?.dataSource else { fatalError("Self out of scope") }

            do {
                try JSONDataManager().write(data: items, to: Self.savedFileURL)
            } catch {
                print("Failed to save locations.")
            }
        }
    }
}
