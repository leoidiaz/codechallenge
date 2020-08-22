//
//  Weather.swift
//  weatherChallenge
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import Foundation

struct TopLevelWeather: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
    let rain: Rain?
}

struct Weather: Codable {
    let icon: String
    let main: String
}

struct Main: Codable {
    let tempMin: Double
    let tempMax: Double
    let temp: Double
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp
    }
}

struct Rain: Codable {
    let lastOneHour: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastOneHour = "1h"
    }
}
