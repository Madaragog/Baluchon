//
//  FakeResponseData.swift
//  WeatherServiceTests
//
//  Created by Cedric on 18/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class FakeResponseDataNYC {
    static let responseOk = HTTPURLResponse(url: URL(string: "Https://www.openclassrooms.fr")!,
                                     statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKo = HTTPURLResponse(url: URL(string: "Https://www.openclassrooms.fr")!,
                                     statusCode: 500, httpVersion: nil, headerFields: nil)!

    class ConverterError: Error {}
    static let error = ConverterError()

    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataNYC.self)
        let url = bundle.url(forResource: "WeatherNYC", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        return data!
    }

    static let weatherIncorrectData = "erreur".data(using: .utf8)!
}
