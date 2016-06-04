//
//  ConversionTests.swift
//  meteoForecast
//
//  Created by Arthur Daurel on 04/06/16.
//  Copyright © 2016 Arthur Daurel. All rights reserved.
//

import XCTest
@testable import meteoForecast

class ConversionTests: XCTestCase {
    
    let conversion = Conversion()
    
    func testGetHour() {
        let result = conversion.getHour(1451651400)
        
        XCTAssertEqual(result, 13)
    }
    
    func testGetMin() {
        let result = conversion.getMin(1451651400)
        
        XCTAssertEqual(result, 30)
    }
    
    func testGetDaily() {
        let result = conversion.getDaily(1451651400)
        
        XCTAssertEqual(result, 6)
    }
    
    func testFahrenheitToCelsius() {
        let result = conversion.fahrenheitToCelsius(60)
        
        XCTAssertEqual(result, 15)
    }
    
    func testConvertDegreesValueWithoutDegrees() {
        let result = conversion.convertDegreesValue("Bonjour j'ai 21ans !")
        
        XCTAssertEqual(result, "Bonjour j'ai 21ans !")
    }
    
    func testConvertDegreesValueNilArg() {
        let result = conversion.convertDegreesValue("")
        
        XCTAssertEqual(result, "")
    }
    
    func testConvertDegreesValueValid() {
        let result = conversion.convertDegreesValue("Ce soir il fera 60°F")
        
        XCTAssertEqual(result, "Ce soir il fera 15°C")
    }
}
