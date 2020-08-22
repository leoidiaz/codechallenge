//
//  WeatherController.swift
//  weatherChallenge
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import Foundation
import UIKit.UIImage

class WeatherController {
    static private let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?")
    static private let parameterKey = "appid"
    static private let searchMethod = "zip"
    static private let unitsKey = "units"
    static private let unitValue = "imperial"
    static private let apiValue = "da65fafb6cb9242168b7724fb5ab75e7"
    
    //MARK: - Fetch Weather
    static func fetchWeather(with zipCode: String, completion: @escaping (Result<TopLevelWeather, WeatherError>) -> Void) {
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let zipSearch = URLQueryItem(name: searchMethod, value: zipCode)
        let unit = URLQueryItem(name: unitsKey, value: unitValue)
        let appId = URLQueryItem(name: parameterKey, value: apiValue)
        components?.queryItems = [zipSearch, appId, unit]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}

        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let weather = try JSONDecoder().decode(TopLevelWeather.self, from: data)
                completion(.success(weather))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    //MARK: - Fetch weather icon
    static func fetchImage(weather: TopLevelWeather, completion: @escaping (Result<UIImage, WeatherError>) -> Void) {
        guard let iconString = weather.weather.first?.icon else { return completion(.failure(.noData)) }
        
        var baseImageURL = URL(string: "http://openweathermap.org/img/wn")
        baseImageURL?.appendPathComponent(iconString + "@2x.png")
        
        guard let finalURL = baseImageURL else { return completion(.failure(.invalidURL))}
        
         URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
             if let error = error {
                 print(error, error.localizedDescription)
                 return completion(.failure(.thrownError(error)))
             }
             guard let data = data else {return completion(.failure(.noData))}

             guard let animePoster = UIImage(data: data) else { return completion(.failure(.unableToDecode))}

             return completion(.success(animePoster))
         }.resume()
     }
}




