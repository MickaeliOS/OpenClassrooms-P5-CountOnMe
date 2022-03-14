//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    var count: Count!
    
    override func setUp() {
        super.setUp()
        count = Count()
    }
    
    func calculateMe(operand: String) -> [String] {
        count.number = "7 " + operand +  " 2"

        return count.calculateOperation()
    }
    
    func testGivenPlusOperand_WhenCalculateTheOperation_ThenGetTheResult() {
        let result = calculateMe(operand: "+")

        XCTAssertEqual(result, ["9.0"])
    }
    
    func testGivenMinusOperand_WhenCalculateOperation_ThenGetTheResult() {
        let result = calculateMe(operand: "-")
        
        XCTAssertEqual(result, ["5.0"])
    }
    
    func testGivenMultiplicationOperand_WhenCalculateOperation_ThenGetTheResult() {
        let result = calculateMe(operand: "*")
        
        XCTAssertEqual(result, ["14.0"])
    }
    
    func testGivenDivisionOperand_WhenCalculateOperation_ThenGetTheResult() {
        let result = calculateMe(operand: "/")
        
        XCTAssertEqual(result, ["3.5"])
    }
    
    func testGivenResult_WhenAddOperand_ThenWeCanContinueOperation() {
        let firstOperation = calculateMe(operand: "+")
        
        count.addOperand(operand: "-")
        count.addNumber(numberToAdd: "5")
        let finalOperation = count.calculateOperation()
        
        XCTAssertEqual(finalOperation, ["5"])
    }
}
