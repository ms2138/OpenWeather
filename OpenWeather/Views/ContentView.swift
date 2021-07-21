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
    @AppStorage("temperatureUnit") var temperatureUnit: TemperatureUnit = TemperatureUnit.celsius
    @State private var temperatureUnitButtonOpacity: Double = 1.0
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(currentWeatherViewModel.dataSource) { weather in
                        HStack {
                            NavigationLink(destination: WeatherDetailView(currentForecast: weather,
                                                                          coordinates: Coordinates(latitude: weather.coord.lat,
                                                                                                   longitude: weather.coord.lon),
                                                                          temperatureUnit: $temperatureUnit)) {
                                
                                CurrentWeatherRowView(weather: weather, temperatureUnit: $temperatureUnit)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        currentWeatherViewModel.dataSource.remove(atOffsets: indexSet)
                    }

                    HStack(alignment: .center) {
                        Button(action: {
                            temperatureUnit = temperatureUnit == .celsius ? .fahrenheit : .celsius
                            withAnimation(.easeInOut(duration: 0.5), {
                                self.temperatureUnitButtonOpacity = 0.0
                            })
                            withAnimation(.easeInOut(duration: 1), {
                                self.temperatureUnitButtonOpacity = 1.0
                            })
                        }) {
                            Text("\(temperatureUnit == .celsius ? "C°" : "F°")")
                                .opacity(temperatureUnitButtonOpacity)
                        }
                        .foregroundColor(.blue)
                        .buttonStyle(PlainButtonStyle())

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
                .navigationBarTitle("Weather")
            }
            .onAppear {
                if self.currentWeatherViewModel.dataSource.count == 0 {
                    currentWeatherViewModel.load()
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { currentWeatherViewModel.save() }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
