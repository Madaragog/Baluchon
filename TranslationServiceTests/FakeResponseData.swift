//
//  FakeResponseData.swift
//  TranslationServiceTests
//
//  Created by Cedric on 11/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class FakeResponseData {
    static let responseOk = HTTPURLResponse(url: URL(string: "Https://www.openclassrooms.fr")!,
                                     statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKo = HTTPURLResponse(url: URL(string: "Https://www.openclassrooms.fr")!,
                                     statusCode: 500, httpVersion: nil, headerFields: nil)!

    class ConverterError: Error {}
    static let error = ConverterError()

    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        return data!
    }

    static let translationIncorrectData = "erreur".data(using: .utf8)!
}
