//
//  TrranslationService.swift
//  Baluchon
//
//  Created by Cedric on 05/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class TranslationService {
    private static let key = APIKeyManager().fixerKey
    private static let translationUrl = URL(
        string: "http://data.fixer.io/api/latest?access_key=\(key)")!
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)

    init() {}
// Init for tests by creating a double of the class.
    init(session: URLSession) {
        self.session = session
    }
// Sets the parameters for the body of the request.
    private func setParameters(text: String) -> String {
        let parameters = "q=\(text)&source=fr&target=en&format=text"
        return parameters
    }
// Gets the translation and returns it.
    func getTranslation(texte: String, callback: @escaping (String?) -> Void) {
        var request = URLRequest(url: TranslationService.translationUrl)
        request.httpMethod = "POST"
        request.httpBody = setParameters(text: texte).data(using: String.Encoding.utf8)

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
                callback(texte)
            }
        }
        task?.resume()
    }
}
