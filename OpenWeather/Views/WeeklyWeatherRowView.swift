//
//  WeeklyWeatherRowView.swift
//  OpenWeather
//
//  Created by mani on 2021-07-05.
//

import SwiftUI

struct WeeklyWeatherRowView: View {
    let viewModel: WeatherRowViewModel
    @Binding var temperatureUnit: TemperatureUnit

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(viewModel.day)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            VStack(alignment: .leading) {
                Text("\(viewModel.icon)")
                    .font(.body)
                    .frame(maxWidth: .infinity)

                Text("\(viewModel.description)")
                    .font(.footnote)
                    .frame(maxWidth: .infinity)

            }

            HStack(alignment: .center, spacing: 10.0) {
                Text(String(format: "%.1f°", convert(temperature: viewModel.maxTemperature, to: temperatureUnit)))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Text(String(format: "%.1f°", convert(temperature: viewModel.minTemperature, to: temperatureUnit)))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

struct WeeklyWeatherRowView_Previews: PreviewProvider {
    @State static var viewModel = WeatherRowViewModel(forecast: Forecast(date: Date(), sunrise: Date(),
                                                                         sunset: Date(), moonrise: Date(), moonset: Date(),
                                                                         moonPhase: 23.0, temp: Temp(day: 23.0, min: 23.0, max: 23.0,
                                                                                                     night: 23.0, eve: 23.0, morn: 23.0),
                                                                         feelsLike: FeelsLike(day: 12.0, night: 12.0, eve: 23.0, morn: 23.0),
                                                                         pressure: 12, humidity: 12, dewPoint: 21.2, windSpeed: 23.3,
                                                                         windDeg: 32, windGust: 34.3, weather:
                                                                            [Weather(id: 393, main: .clear,
                                                                                     weatherDescription: "clear sky", icon: "39d")],
                                                                         clouds: 12, pop: 293.9, rain: nil, uvi: 13), timeZone: "America/New_York")
    @State static var temperatureUnit = TemperatureUnit.celsius

    static var previews: some View {
        WeeklyWeatherRowView(viewModel: viewModel, temperatureUnit: $temperatureUnit)
    }
}
