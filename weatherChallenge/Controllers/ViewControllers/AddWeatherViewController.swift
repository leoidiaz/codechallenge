//
//  AddWeatherViewController.swift
//  weatherChallenge
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

class AddWeatherViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var addToListButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton()
        zipTextField.delegate = self
    }
    //MARK: - Properties
    weak var delegate: ReloadWeatherDataDelegate?
    
    //MARK: - Helper Methods
    @IBAction func addToListButtonTapped(_ sender: Any) {
        guard let zipCodeInput = zipTextField.text, !zipCodeInput.isEmpty else {  presentErrorToUser(localizedError: WeatherError.emptyTextField) ; return }
        if isValidZip(zipCodeInput) {
            WeatherController.fetchWeather(with: zipCodeInput) { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let newWeather):
                        self?.delegate?.addNewWeather(weather: newWeather)
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        self?.presentErrorToUser(localizedError: WeatherError.thrownError(error))
                    }
                }
            }
        } else {
            presentErrorToUser(localizedError: WeatherError.invalidZipCode)
        }
    }
    
    func styleButton(){
        addToListButton.layer.cornerRadius = 12
    }
}

    //MARK: - TextField Delegates
extension AddWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return zipTextField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
