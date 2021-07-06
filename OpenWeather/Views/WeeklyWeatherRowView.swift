//
//  WeeklyWeatherRowView.swift
//  OpenWeather
//
//  Created by mani on 2021-07-05.
//

import SwiftUI

struct WeeklyWeatherRowView: View {
    private let viewModel: WeeklyWeatherViewModel

    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WeeklyWeatherRowView_Previews: PreviewProvider {
    @State static var viewModel = WeeklyWeatherViewModel()

    static var previews: some View {
        WeeklyWeatherRowView(viewModel: viewModel)
    }
}
