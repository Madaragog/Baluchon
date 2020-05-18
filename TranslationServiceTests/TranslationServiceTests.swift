//
//  TranslationServiceTests.swift
//  TranslationServiceTests
//
//  Created by Cedric on 11/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//
@testable import Baluchon
import XCTest

class CurrencyConversionServiceTests: XCTestCase {
    let textToTranslate = "Bonjour"
    let translatedTextResponse = "Hello"

    func testGetTranslationShouldPostFailCallbackIfError() {
//        Given
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil,
                                                                            error: FakeResponseData.error))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: textToTranslate) { (translatedTexte) in
//        Then
            XCTAssertNil(translatedTexte)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailCallbackIfNoData() {
//        Given
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil,
                                                                            error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: textToTranslate) { (translatedTexte) in
//        Then
            XCTAssertNil(translatedTexte)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailCallbackIfIncorrectResponse() {
//        Given
        let translationService = TranslationService(session: URLSessionFake(
                                                                        data: FakeResponseData.translationCorrectData,
                                                                        response: FakeResponseData.responseKo,
                                                                        error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: textToTranslate) { (translatedTexte) in
//        Then
            XCTAssertNil(translatedTexte)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailCallbackIfIncorrectData() {
//        Given
        let translationService = TranslationService(session: URLSessionFake(
                                                                        data: FakeResponseData.translationIncorrectData,
                                                                        response: FakeResponseData.responseOk,
                                                                        error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: textToTranslate) { (translatedTexte) in
//        Then
            XCTAssertNil(translatedTexte)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }

    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        Given
        let translationService = TranslationService(session: URLSessionFake(
                                                                        data: FakeResponseData.translationCorrectData,
                                                                        response: FakeResponseData.responseOk,
                                                                        error: nil))
//        When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation(text: textToTranslate) { (translatedTexte) in
//        Then
            XCTAssertNotNil(translatedTexte)
            XCTAssertEqual(translatedTexte, self.translatedTextResponse)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
}
