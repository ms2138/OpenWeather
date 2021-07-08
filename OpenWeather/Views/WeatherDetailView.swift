//
//  WeatherDetailView.swift
//  OpenWeather
//
//  Created by mani on 2021-07-02.
//

import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject private var viewModel = WeeklyWeatherViewModel()
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
                    forecastSection
                    Section {
                        sunInfoSection
                        rainInfoSection
                        additionalInfoSection
                    }
                }
        }
    }
}

private extension WeatherDetailView {
    var forecastSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: WeeklyWeatherRowView.init(viewModel:))
        }
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
    @State static var coord = Coordinates(latitude: 23.0, longitude: 45.0)

    static var previews: some View {
        WeatherDetailView(coordinates: coord)
    }
}

