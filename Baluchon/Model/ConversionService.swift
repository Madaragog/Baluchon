//
//  ConversionService.swift
//  Baluchon
//
//  Created by Cedric on 02/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class ConversionService {
    private let oneMileInKm = 1.609

    func milesToKilometers(miles: Double) -> Double {
        let kilometers = miles * oneMileInKm
        let kilometersRounded = round(1000*kilometers)/1000
        return kilometersRounded
    }
}
