//
//  ConverterService.swift
//  Baluchon
//
//  Created by Cedric on 22/04/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class ConverterService {
    static var shared = ConverterService()
    private init() {}

    private static let key = APIKeyManager().fixerKey
    private static let converterUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(key)&symbols=USD,EUR")!

    private var task: URLSessionDataTask?
    func getCurrency(callback: @escaping (Bool, Converter?) -> Void) {
        var request = URLRequest(url: ConverterService.converterUrl)
        request.httpMethod = "POST"
        let session = URLSession(configuration: .default)

        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                            let rates = json["rates"] {
                            if let values = rates as? [String: Double] {
                                if let usd = values["USD"] {
                                    let converter = Converter(dollarValue: usd)
                                    callback(true, converter)
                                } else {
                                    callback(false, nil)
                                }
                            } else {
                                callback(false, nil)
                            }
                        } else {
                            callback(false, nil)
                        }
                    } else {
                        callback(false, nil)
                    }
                } else {
                    callback(false, nil)
                }
            }
        }
        task?.resume()
    }
}
