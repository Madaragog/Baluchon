//
//  DistanceConversionServiceTests.swift
//  DistanceConversionServiceTests
//
//  Created by Cedric on 05/05/2020.
//  Copyright © 2020 Cedric. All rights reserved.
//
@testable import Baluchon
import XCTest

class DistanceConversionServiceTests: XCTestCase {
    func testGivenMilesWhenConvertingThenResultShouldBeTheEquivalentInKms() {
//        Given
        let expectedKilometer = 16.09
        let miles = 10.0
//        When
        let distanceInKilometer = DistanceConversionService().milesToKilometers(miles: miles)
//        Then
        XCTAssertEqual(expectedKilometer, distanceInKilometer)
    }
}
