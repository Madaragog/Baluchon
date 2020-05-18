//
//  WeatherServiceTests.swift
//  WeatherServiceTests
//
//  Created by Cedric on 18/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//
@testable import Baluchon
import XCTest

class WeatherServiceTests: XCTestCase {
    let tempNYC = 13.78000000000003
    let descriptionNYC = "couvert"
    let tempRennes = 21.0
    let descriptionRennes = "ciel dégagé"

    func testGetNYCWeatherShouldPostFailCallbackIfError() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil,
                                                                                error: FakeResponseDataNYC.error))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getNYCWeather { (tempNYC, descriptionNYC) in
//        Then
            XCTAssertNil(tempNYC)
            XCTAssertNil(descriptionNYC)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetNYCWeatherShouldPostFailCallbackIfNoData() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil,
                                                                    error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getNYCWeather { (tempNYC, descriptionNYC) in
//        Then
            XCTAssertNil(tempNYC)
            XCTAssertNil(descriptionNYC)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetNYCWeatherShouldPostFailCallbackIfIncorrectResponse() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseDataNYC.weatherCorrectData,
                                                                    response: FakeResponseDataNYC.responseKo,
                                                                    error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getNYCWeather { (tempNYC, descriptionNYC) in
//        Then
            XCTAssertNil(tempNYC)
            XCTAssertNil(descriptionNYC)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetNYCWeatherShouldPostFailCallbackIfIncorrectData() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseDataNYC.weatherIncorrectData,
                                                                    response: FakeResponseDataNYC.responseOk,
                                                                    error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getNYCWeather { (tempNYC, descriptionNYC) in
//        Then
            XCTAssertNil(tempNYC)
            XCTAssertNil(descriptionNYC)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetNYCWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseDataNYC.weatherCorrectData,
                                                                    response: FakeResponseDataNYC.responseOk,
                                                                    error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getNYCWeather { (tempNYC, descriptionNYC) in
//        Then
            XCTAssertNotNil(tempNYC)
            XCTAssertNotNil(descriptionNYC)
            XCTAssertEqual(tempNYC!, self.tempNYC)
            XCTAssertEqual(descriptionNYC!, self.descriptionNYC)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetRennesWeatherShouldPostFailCallbackIfError() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil,
                                                                    response: nil,
                                                                    error: FakeResponseDataRennes.error))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getRennesWeather { (tempNYC, descriptionNYC) in
//        Then
            XCTAssertNil(tempNYC)
            XCTAssertNil(descriptionNYC)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetRennesWeatherShouldPostFailCallbackIfNoData() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil,
                                                                        error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getRennesWeather { (tempNYC, descriptionNYC) in
//        Then
            XCTAssertNil(tempNYC)
            XCTAssertNil(descriptionNYC)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetRennesWeatherShouldPostFailCallbackIfIncorrectResponse() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseDataRennes.weatherCorrectData,
                                                                        response: FakeResponseDataRennes.responseKo,
                                                                        error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getRennesWeather { (tempNYC, descriptionNYC) in
//        Then
            XCTAssertNil(tempNYC)
            XCTAssertNil(descriptionNYC)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetRennesWeatherShouldPostFailCallbackIfIncorrectData() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseDataRennes.weatherIncorrectData,
                                                                        response: FakeResponseDataRennes.responseOk,
                                                                        error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getRennesWeather { (tempNYC, descriptionNYC) in
//        Then
            XCTAssertNil(tempNYC)
            XCTAssertNil(descriptionNYC)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetRennesWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseDataRennes.weatherCorrectData,
                                                                        response: FakeResponseDataRennes.responseOk,
                                                                        error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getRennesWeather { (tempRennes, descriptionRennes) in
//        Then
            XCTAssertNotNil(tempRennes)
            XCTAssertNotNil(descriptionRennes)
            XCTAssertEqual(tempRennes!, self.tempRennes)
            XCTAssertEqual(descriptionRennes!, self.descriptionRennes)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
}
