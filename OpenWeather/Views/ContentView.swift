//
//  ContentView.swift
//  OpenWeather
//
//  Created by mani on 2021-06-06.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var currentWeatherViewModel = CurrentWeatherViewModel()
    @State private var addCityConfig = AddCityConfig()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(currentWeatherViewModel.dataSource) { weather in
                        HStack {
                            NavigationLink(destination: WeatherDetailView(coordinates: Coordinates(latitude: weather.coord.lat,
                                                                                                   longitude: weather.coord.lon))) {
                                CurrentWeatherRowView(weather: weather)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Weather")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
