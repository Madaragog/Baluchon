//
//  ConverterServiceTests.swift
//  ConverterServiceTests
//
//  Created by Cedric on 25/04/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//

@testable import Baluchon
import XCTest

class CurrencyConversionServiceTests: XCTestCase {
    let euro: Double = 10.23

    func testConvertToUsdShouldPostFailCallbackIfError() {
//        Given
        let converterService = CurrencyConversionService(session: URLSessionFake(data: nil, response: nil,
                                                                                 error: FakeResponseData.error))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        converterService.convertToUsd(euro: euro) { (usd) in
//        Then
            XCTAssertNil(usd)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testConvertToUsdShouldPostFailCallbackIfNoData() {
//        Given
        let converterService = CurrencyConversionService(session: URLSessionFake(data: nil, response: nil,
                                                                                 error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        converterService.convertToUsd(euro: euro) { (usd) in
//        Then
            XCTAssertNil(usd)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testConvertToUsdShouldPostFailCallbackIfIncorrectResponse() {
//        Given
        let converterService = CurrencyConversionService(session: URLSessionFake(
                                                            data: FakeResponseData.converterCorrectData,
                                                            response: FakeResponseData.responseKo, error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        converterService.convertToUsd(euro: euro) { (usd) in
//        Then
            XCTAssertNil(usd)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testConvertToUsdShouldPostFailCallbackIfIncorrectData() {
//        Given
        let converterService = CurrencyConversionService(session: URLSessionFake(
                                                            data: FakeResponseData.converterIncorrectData,
                                                            response: FakeResponseData.responseOk, error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        converterService.convertToUsd(euro: euro) { (usd) in
//        Then
            XCTAssertNil(usd)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testConvertToUsdShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        Given
        let converterService = CurrencyConversionService(session: URLSessionFake(
                                                            data: FakeResponseData.converterCorrectData,
                                                        response: FakeResponseData.responseOk, error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        converterService.convertToUsd(euro: euro) { (usd) in
//        Then
            let usdRate = 1.082205
            XCTAssertNotNil(usd)
            XCTAssertEqual(usdRate * self.euro, usd!)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
}
