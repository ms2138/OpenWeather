//
//  SearchBarView.swift
//  OpenWeather
//
//  Created by mani on 2021-06-16.
//

import SwiftUI

struct AddCityView: View {
    @ObservedObject var viewModel = LocationViewModel()
    
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
    static var previews: some View {
        AddCityView()
    }
}
