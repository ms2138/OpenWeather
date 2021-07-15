//
//  CurrentWeatherRowView.swift
//  OpenWeather
//
//  Created by mani on 2021-07-04.
//

import SwiftUI

struct CurrentWeatherRowView: View {
    let weather: CurrentWeatherForecast
    @Binding var temperatureUnit: TemperatureUnit

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(weather.name)")
                Text("\(weather.weather.first!.weatherDescription)")
                    .autocapitalization(.words)
                    .font(.caption2)
            }
            Spacer()
            Text("\(String(format: "%.1f", convert(temperature: weather.main.temperature, to: temperatureUnit)))°")
                .font(.title)
        }
    }
}

struct CurrentWeatherRowView_Previews: PreviewProvider {
    @State static var weather = CurrentWeatherForecast(id: 19282, name: "Madison", coord: Coord(lat: 12.3, lon: 12.3),
                                                       weather: [CurrentWeatherForecast.Weather(id: 3838, main: "Clear",
                                                                         weatherDescription: "clear sky", icon: "01d")],
                                                       main: .init(temperature: 23.4, humidity: 3,
                                                                   maxTemperature: 25.0, minTemperature: 18.0))
    @State static var temperatureUnit = TemperatureUnit.celsius

    static var previews: some View {
        CurrentWeatherRowView(weather: weather, temperatureUnit: $temperatureUnit)
    }
}
