//
//  weatherChallengeTests.swift
//  weatherChallengeTests
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import XCTest
@testable import weatherChallenge

class weatherChallengeTests: XCTestCase {
    
    var weatherSample: TopLevelWeather!
    var urlService: URLService!
    
    override func setUp() {
        super.setUp()
        weatherSample = TopLevelWeather(name: "San Francisco", weather: [Weather(icon: "50d", main: "Smoke")], main: Main(tempMin: 61.0, tempMax: 78.0, temp: 69.0), rain: Rain(lastOneHour: nil))
        urlService = URLService()
    }
    
    override func tearDown() {
        super.tearDown()
        weatherSample = nil
        urlService = nil
    }
    
    
    func test_valid_response() throws {
        WeatherController.fetchWeather(with: "90013") { (result) in
            switch result {
            case .success(let city):
                XCTAssertEqual(city.name, "Los Angeles")
                XCTAssertNotNil(city.weather.first?.icon)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func test_valid_image() throws {
        WeatherController.fetchImage(weather: weatherSample) { (result) in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func test_valid_url() throws {
        let testURL = "https://api.openweathermap.org/data/2.5/weather?zip=10001&appid=da65fafb6cb9242168b7724fb5ab75e7&units=imperial"
        let resultURL = try urlService.returnURL(zipCode: "10001")
        XCTAssertNotNil(resultURL)
        XCTAssertEqual(resultURL.absoluteString, testURL)
    }
    
    func test_zip_validation() throws {
        XCTAssertTrue(isValidZip("90231"))
        XCTAssertFalse(isValidZip("blueberry"))
        XCTAssertFalse(isValidZip("9323"))
        XCTAssertTrue(isValidZip("00001"))
        XCTAssertFalse(isValidZip("1010a"))
    }
}
