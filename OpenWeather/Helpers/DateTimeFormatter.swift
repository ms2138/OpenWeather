//
//  DateTimeFormatter.swift
//  OpenWeather
//
//  Created by mani on 2021-07-03.
//

import Foundation

let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return formatter
}()

let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.dateFormat = "EEEE"
    return formatter
}()
