//
//  JSONDataManager.swift
//  OpenWeather
//
//  Created by mani on 2021-07-14.
//

import Foundation

class JSONDataManager<T: Codable> {
    func write(data: T, to url: URL) throws {
        let encodedFeeds = try JSONEncoder().encode(data)
        try encodedFeeds.write(to: url)
    }

    func read(from url: URL) throws -> [T] {
        let savedData = try Data(contentsOf: url)
        let decodedData = try JSONDecoder().decode([T].self, from: savedData)
        return decodedData
    }
}
