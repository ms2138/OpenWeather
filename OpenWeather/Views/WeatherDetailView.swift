//
//  WeatherDetailView.swift
//  OpenWeather
//
//  Created by mani on 2021-07-02.
//

import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject private var viewModel = WeeklyWeatherViewModel()
    var currentForecast: CurrentWeatherForecast
    var coordinates: Coordinates

    var body: some View {
        switch viewModel.state {
            case .idle:
                Color.clear.onAppear {
                    viewModel.weeklyWeather(forCoordinates: coordinates)
                }
            case .loading:
                ProgressView()
            case .failed(let error):
                Text("No results \(error.localizedDescription)")
            case .loaded:
                List {
                    Section {
                        todaysForecast
                    }
                    Section(header: Text("")) {
                        weeklyForecast
                    }
                    Section(header: Text("")) {
                        sunInfoSection
                        rainInfoSection
                        additionalInfoSection
                    }
                }
        }
    }
}

private extension WeatherDetailView {
    var todaysForecast: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("\(currentForecast.name)")
                        .font(.largeTitle)
                    Text("\(currentForecast.weather.first!.weatherDescription)")
                        .font(.caption)
                    HStack {
                        Text("H: \(String(format: "%.1f", currentForecast.main.maxTemperature))°")
                            .font(.caption)
                        Text("L: \(String(format: "%.1f", currentForecast.main.minTemperature))°")
                            .font(.caption)
                    }
                }
                Spacer()
                Text("\(String(format: "%.1f", currentForecast.main.temperature))°")
                    .font(.largeTitle)
            }
            Spacer()
        }
    }

    var weeklyForecast: some View {
        ForEach(viewModel.dataSource, content: WeeklyWeatherRowView.init(viewModel:))
    }

    var sunInfoSection: some View {
        VStack {
            if let firstForecast = viewModel.dataSource.first {
                HStack {
                    WeatherInfoView(title: "SUNRISE", information: "\(firstForecast.sunrise)")
                    WeatherInfoView(title: "SUNSET", information: "\(firstForecast.sunset)")
                }
            }
        }
    }

    var rainInfoSection: some View {
        VStack {
            if let firstForecast = viewModel.dataSource.first {
                HStack {
                    WeatherInfoView(title: "CHANCE OF RAIN", information: "\(firstForecast.precipitation)")
                    WeatherInfoView(title: "HUMIDITY", information: "\(firstForecast.humidity)")
                }
            }
        }
    }

    var additionalInfoSection: some View {
        VStack {
            if let firstForecast = viewModel.dataSource.first {
                HStack {
                    WeatherInfoView(title: "UV", information: "\(firstForecast.uvIndex)")
                    WeatherInfoView(title: "FEELS LIKE", information: "\(firstForecast.feelsLike)")
                }
            }
        }
    }
}

struct WeatherInfoView: View {
    var title: String
    var information: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption2)
            Text(information)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}



struct WeatherDetailView_Previews: PreviewProvider {
    @State static var weather = CurrentWeatherForecast(id: 19282, name: "Madison", coord: Coord(lat: 12.3, lon: 12.3),
                                                       weather: [CurrentWeatherForecast.Weather(id: 3838, main: "Clear",
                                                                                                weatherDescription: "clear sky", icon: "01d")],
                                                       main: .init(temperature: 23.4, humidity: 3,
                                                                   maxTemperature: 25.0, minTemperature: 18.0))
    @State static var coord = Coordinates(latitude: 23.0, longitude: 45.0)

    static var previews: some View {
        WeatherDetailView(currentForecast: weather, coordinates: coord)
    }
}

