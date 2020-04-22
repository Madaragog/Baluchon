//
//  ConverterService.swift
//  Baluchon
//
//  Created by Cedric on 22/04/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class ConverterService {
    private static let key = APIKeyManager().fixerKey
    private static let converterUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(key)")
}
