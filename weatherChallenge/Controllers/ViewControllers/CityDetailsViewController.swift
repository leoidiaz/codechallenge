//
//  CityDetailsViewController.swift
//  weatherChallenge
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

class CityDetailsViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var percipLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Properties
    var city: TopLevelWeather?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Helper Methods
    private func setupView() {
        guard let city = city else { return }
        nameLabel.text = city.name
        descriptionLabel.text = city.weather.first?.main ?? ""
        WeatherController.fetchImage(weather: city) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let icon):
                    self?.iconImageView.image = icon
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
        currentTempLabel.text = convertToString(temperature: city.main.temp)
        highTempLabel.text = convertToString(temperature: city.main.tempMax)
        lowTempLabel.text = convertToString(temperature: city.main.tempMin)
        percipLabel.text = convertWaterVolume(amount: city.rain?.lastOneHour ?? 0)
    }
}
