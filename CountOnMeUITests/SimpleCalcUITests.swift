//
//  SimpleCalcUITests.swift
//  SimpleCalcUITests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testGivenNoCountClass_WhenCreateCountClass_ThenCountClassIsCreated() {
        let count = Count()
        XCTAssertNotNil(count)
    }
    
    func testGivenAnOperation_WhenCalculateTheOperation_ThenGetTheResult() {
        let count = Count()
        
        count.elements = ["7", "+", "2"]
        let result = count.calculateOperation(elements: count.elements)
        
        
        XCTAssertEqual(result, ["9"])
    }
}
