//
//  ConverterService.swift
//  Baluchon
//
//  Created by Cedric on 22/04/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class CurrencyConversionService {
    private static let key = APIKeyManager().fixerKey
    private static let converterUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(key)&symbols=USD,EUR")!

    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    private var usdRate: Double?

    init() {}
// Init for tests by creating a double of the class.
    init(session: URLSession) {
        self.session = session
    }
// Converts euro to dollar.
    func convertToUsd(euro: Double, callback: @escaping (Double?) -> Void) {
        if let usdRate = self.usdRate {
            callback(usdRate * euro)
        } else {
            getCurrency { (usdRate) in
                if let usdRate = usdRate {
                    self.usdRate = usdRate
                    callback(usdRate * euro)
                } else {
                    callback(nil)
                }
            }
        }
    }
// Checks the current dollar value and returns it.
    private func getCurrency(callback: @escaping (Double?) -> Void) {
        var request = URLRequest(url: CurrencyConversionService.converterUrl)
        request.httpMethod = "POST"

        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(nil)
                    return
                }
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let rates = json["rates"] as? [String: Double] else {
                        callback(nil)
                        return
                }
                guard let usd = rates["USD"] else {
                    callback(nil)
                    return
                }
                callback(usd)
            }
        }
        task?.resume()
    }
}
