//
//  SearchBarView.swift
//  OpenWeather
//
//  Created by mani on 2021-06-16.
//

import SwiftUI

struct AddCityView: View {
    @ObservedObject var viewModel = LocationViewModel()
    @Binding var addCityConfig: AddCityConfig

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Add a city name")
                        .font(.caption)
                    Spacer()
                }
                .padding(.top, 20.0)

                searchField
            }
        }
    }
}

private extension AddCityView {
    var searchField: some View {
        HStack {
            TextField("Search", text: $viewModel.city)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .padding(.horizontal, 10)
            Button(action: {

            }) {
                Text("Cancel")
            }
            .padding(.trailing, 10)
        }
    }
}

struct AddCityView_Previews: PreviewProvider {
    @State static var addCityConfig = AddCityConfig()

    static var previews: some View {
        AddCityView(addCityConfig: $addCityConfig)
    }
}


// AddCityConfig
//
// Configuration data for displaying the AddCityView as a sheet
struct AddCityConfig {
    var isPresented = false
    var newLocation = LocationElement(name: "",
                                      lat: 0.0, lon: 0.0,
                                      country: "", state: "")
    var needsSave = false

    mutating func present() {
        isPresented = true
        newLocation = LocationElement(name: "",
                                      lat: 0.0, lon: 0.0,
                                      country: "", state: "")
        needsSave = false
    }

    mutating func dismiss(save: Bool = false) {
        isPresented = false
        needsSave = save
    }
}
