//
//  LoadingState.swift
//  OpenWeather
//
//  Created by mani on 2021-07-05.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case failed(Error)
    case loaded
}
