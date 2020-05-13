//
//  ConversionService.swift
//  Baluchon
//
//  Created by Cedric on 02/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class DistanceConversionService {
    private let oneMileInKm = 1.609
    private let oneKmInMile = 0.62
// Converts miles to kilometers
    func milesToKilometers(miles: Double) -> Double {
        let kilometers = miles * oneMileInKm
        return kilometers
    }
// Converts kilometers to miles
    func kilometersToMiles(kilometers: Double) -> Double {
        let miles = kilometers * oneKmInMile
        return miles
    }
}
