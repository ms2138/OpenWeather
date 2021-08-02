//
//  DateTimeFormatter.swift
//  OpenWeather
//
//  Created by mani on 2021-07-03.
//

import Foundation

func timeFormatter(forTimeZone timeZone: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    formatter.timeZone = TimeZone(identifier: timeZone)
    return formatter
}

let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.dateFormat = "EEEE"
    return formatter
}()

let timeOfTheDay: TimeOfDay = {
    let hour = Calendar.current.component(.hour, from: Date())

    switch hour {
        case 6..<12 : return .morning
        case 12..<17 : return .day
        case 17..<22 : return .evening
        default: return .night
    }
}()

enum TimeOfDay {
    case morning, day, evening, night
}
