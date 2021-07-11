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
                            NavigationLink(destination: WeatherDetailView(currentForecast: weather,
                                                                          coordinates: Coordinates(latitude: weather.coord.lat,
                                                                                                   longitude: weather.coord.lon))) {
                                CurrentWeatherRowView(weather: weather)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        currentWeatherViewModel.dataSource.remove(atOffsets: indexSet)
                    }

                    HStack(alignment: .center) {
                        Spacer()

                        Button(action: {
                            addCityConfig.present()
                        }) {
                            Image(systemName: "plus.circle")
                        }
                        .foregroundColor(.blue)
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $addCityConfig.isPresented, onDismiss: {
                            if addCityConfig.needsSave {
                                currentWeatherViewModel.currentWeather(forCoordinates:
                                                                        Coordinates(latitude: addCityConfig.newLocation.lat,
                                                                                    longitude: addCityConfig.newLocation.lon))
                            }
                        }, content: {
                            AddCityView(addCityConfig: $addCityConfig)
                        })
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
