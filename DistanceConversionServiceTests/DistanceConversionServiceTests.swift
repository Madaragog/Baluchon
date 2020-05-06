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
    func testGiven10milesWhenConvertingThenResultShouldBe1Point609MultiplicatedBy10() {
//        Given
        let oneMileInKm = 1.609
        let miles = 10.0
//        When
        let distanceConversionService = DistanceConversionService().milesToKilometers(miles: miles)
//        Then
        XCTAssertEqual(distanceConversionService, oneMileInKm * miles)
    }
}
