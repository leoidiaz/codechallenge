//
//  Factories.swift
//  weatherChallenge
//
//  Created by Leonardo Diaz on 8/21/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import Foundation

func convertToString(temperature: Double) -> String {
    return String(format: "%2.f", temperature) + "°"
}

func convertWaterVolume(amount: Double?) -> String {
    guard let actualData = amount else { return "0 mm"}
    return "\(actualData) mm"
}

func isValidZip(_ zipCode: String) -> Bool {
    let zipRegEx = "(^\\d{5}([-]\\d{4})|([ ]\\d{4})|\\d{5}|[A-Z]\\d[A-Z] \\d[A-Z]\\d$){1}"
    let zipPred = NSPredicate(format:"SELF MATCHES %@", zipRegEx)
    return zipPred.evaluate(with: zipCode)
}
