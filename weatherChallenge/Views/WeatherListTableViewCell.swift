//
//  WeatherListTableViewCell.swift
//  weatherChallenge
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    //MARK: - Properties
    var city: TopLevelWeather? {
        didSet {
            setupCell()
        }
    }
    
    //MARK: - Helper Methods
    private func setupCell(){
        guard let city = city else { return }
        cityNameLabel.text = city.name
        temperatureLabel.text = convertToString(temperature: city.main.temp)
        
        WeatherController.fetchImage(weather: city) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let icon):
                    self?.weatherIcon.image = icon
                case .failure(let error):
                    self?.weatherIcon.image = nil
                    print(error.localizedDescription)
                }
            }
        }        
    }
}
