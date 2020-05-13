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
    let expectedUsd: Double = 11.070957150000002

    func testConvertToUsdShouldPostFailCallbackIfError() {
//        Given
        let converterService = CurrencyConversionService(session: URLSessionFake(data: nil, response: nil,
                                                                                 error: FakeResponseData.error))
//        When
        let expectaction = XCTestExpectation(description: "trouver un sens.")
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
            XCTAssertNotNil(usd)
            XCTAssertEqual(self.expectedUsd, usd!)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testfConvertToUsdShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
    //        Given
            let converterService = CurrencyConversionService(session: URLSessionFake(
                                                                data: FakeResponseData.converterCorrectData,
                                                            response: FakeResponseData.responseOk, error: nil))
    //        When
            let expectaction = XCTestExpectation(description: "Wait for queue change.")
            converterService.convertToUsd(euro: euro) { (_) in
    //        Then
                converterService.convertToUsd(euro: self.euro) { (_) in
                    expectaction.fulfill()
                }
            }
            wait(for: [expectaction], timeout: 0.01)
        }
}
