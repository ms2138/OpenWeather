//
//  FileManager+EXT.swift
//  OpenWeather
//
//  Created by mani on 2021-07-14.
//

import Foundation

extension FileManager {
    var documentsDirectory: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Failed to find documents directory.")
        }
    }
}
