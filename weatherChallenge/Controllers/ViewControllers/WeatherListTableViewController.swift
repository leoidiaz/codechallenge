//
//  WeatherListTableViewController.swift
//  weatherChallenge
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

    //MARK: - ReloadWeather Delegate
protocol ReloadWeatherDataDelegate: class {
    func addNewWeather(weather: TopLevelWeather)
}

class WeatherListTableViewController: UITableViewController {
    //MARK: - Properties
    private let cellID = "weatherCellIdentifier"
    private let detailID = "toDetailVC"
    private let addID = "addWeather"
    private let sanFrancisco = "94108"
    private let newYork = "10001"
    private let saltLake = "84101"
    private var weatherList = [TopLevelWeather](){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherList()
        tableView.tableFooterView = UIView()
        navigationItem.leftBarButtonItem = self.editButtonItem
    }
    //MARK: - Helper Methods
    private func fetchWeatherList(){
        fetchDefaultCity(city: sanFrancisco)
        fetchDefaultCity(city: saltLake)
        fetchDefaultCity(city: newYork)
    }
    
    private func fetchDefaultCity(city: String){
        WeatherController.fetchWeather(with: city) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherList):
                    self?.weatherList.append(weatherList)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? WeatherListTableViewCell else { return UITableViewCell()}
        cell.city = weatherList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            weatherList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailID {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? CityDetailsViewController else { return }
            let city = weatherList[indexPath.row]
            destinationVC.city = city
        } else if segue.identifier == addID {
            guard let destinationVC = segue.destination as? AddWeatherViewController else { return }
            destinationVC.delegate = self
        }
    }
}

//MARK: - Reload Delegate Extension
extension WeatherListTableViewController: ReloadWeatherDataDelegate {
    func addNewWeather(weather: TopLevelWeather) {
        weatherList.append(weather)
    }
}
