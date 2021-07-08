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
}

struct WeatherDetailView_Previews: PreviewProvider {
    @State static var coord = Coordinates(latitude: 23.0, longitude: 45.0)

    static var previews: some View {
        WeatherDetailView(coordinates: coord)
    }
}

