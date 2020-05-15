//
//  WeatherService.swift
//  Baluchon
//
//  Created by Cedric on 15/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

import Foundation

class WeatherService {
    private static let key = APIKeyManager().weatherKey
    private static let weatherNYCUrl = URL(
        string: "api.openweathermap.org/data/2.5/weather?q=New York City&appid=\(key)&lang=fr")!
    private static let weatherRennesUrl = URL(
        string: "api.openweathermap.org/data/2.5/weather?q=Rennes&appid=\(key)&lang=fr")!

    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)

    init() {}
// Init for tests by creating a double of the class.
    init(session: URLSession) {
        self.session = session
    }
// Checks the current weather of New York City and returns it.
    func getNYCWeather(city: URL, callback: @escaping (Double?) -> Void) {
        var request = URLRequest(url: WeatherService.weatherNYCUrl)
        
        request.httpMethod = "GET"

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
                guard let openWeatherMapResponse = try? JSONDecoder().decode(OpenWeatherMapResponse.self, from: data) else {
                    callback(nil)
                    return
                }
                callback(openWeatherMapResponse)
            }
        }
        task?.resume()
    }
// Converts kelvin to celsius.
    private func kelvinToCelsius(kelvin: Double) -> Double {
        let celsius = kelvin - 273.15
        return celsius
    }
}
// MARK: - Welcome
struct OpenWeatherMapResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
