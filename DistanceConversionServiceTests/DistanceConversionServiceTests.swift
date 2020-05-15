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
        let expectedKilometers = 16.09
        let miles = 10.0
//        When
        let distanceInKilometer = DistanceConversionService().milesToKilometers(miles: miles)
//        Then
        XCTAssertEqual(expectedKilometers, distanceInKilometer)
    }
    func testGivenKilometersWhenConvertingThenResultShouldBeTheEquivalentInMiles() {
//        Given
        let expectedMiles = 7.51237539
        let kilometers = 12.09
//        When
        let distanceInMiles = DistanceConversionService().kilometersToMiles(kilometers: kilometers)
//        Then
        XCTAssertEqual(expectedMiles, distanceInMiles)
    }
}
