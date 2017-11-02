//
//  AerisWeatherAPITests.swift
//  WeatherCastTests
//
//  Created by Alex Paul on 11/1/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//

import XCTest
@testable import WeatherCast

class AerisWeatherAPITests: XCTestCase {
    
    func testGetWeatherForecasts() {
        let exp = expectation(description: "got weather forecasts")
        var resultCount = 0
        AerisWeatherAPI.getWeatherForecasts { (theResults, theErrorDict, theError) in
            if let error = theError {
                XCTFail("error: \(error.localizedDescription)")
            } else if let results = theResults {
                resultCount = results.count
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 3.0)
        
        XCTAssertGreaterThan(resultCount, 0, "there should be more than 0 results")
    }
    
}
