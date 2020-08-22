//
//  URLService.swift
//  weatherChallengeTests
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import Foundation
@testable import weatherChallenge

struct URLService {
    private let rootURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?")
    private let parameterKey = "appid"
    private let searchMethod = "zip"
    private let unitsKey = "units"
    private let unitValue = "imperial"
    private let apiValue = "da65fafb6cb9242168b7724fb5ab75e7"
    
    func returnURL(zipCode: String) throws -> URL {
        guard let baseURL = rootURL else { throw WeatherError.invalidURL}
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let zipSearch = URLQueryItem(name: searchMethod, value: zipCode)
        let unit = URLQueryItem(name: unitsKey, value: unitValue)
        let appId = URLQueryItem(name: parameterKey, value: apiValue)
        components?.queryItems = [zipSearch, appId, unit]
        guard let finalURL = components?.url else { throw WeatherError.invalidURL }
        return finalURL
    }
}
