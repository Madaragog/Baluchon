//
//  FakeResponseData.swift
//  ConverterServiceTests
//
//  Created by Cedric on 25/04/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class FakeResponseData {
    let responseOk = HTTPURLResponse(url: URL(string: "Https://www.openclassrooms.fr")!,
                                     statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responseKo = HTTPURLResponse(url: URL(string: "Https://www.openclassrooms.fr")!,
                                     statusCode: 500, httpVersion: nil, headerFields: nil)!

    class ConverterError: Error {}
    let error = ConverterError()

    var converterCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Converter", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        return data!
    }

    let converterIncorrectData = "erreur".data(using: .utf8)!
}
