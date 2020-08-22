//
//  WeatherError.swift
//  weatherChallenge
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import Foundation

enum WeatherError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case emptyTextField
    case invalidZipCode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach server."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data."
        case .emptyTextField:
            return "You can't add an empty textfield."
        case .invalidZipCode:
            return "You entered an incorrect zipcode. Double check your zipcode is in the US."
        case .unableToDecode:
            return "The server responded with bad data."
        }
    }
}
