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

    // Priority operand (multiplication)
    func testGivenPlusAndMultiplicationOperand_WhenCalculateOperation_ThenMultiplicationCalculatedFirst() {
        count.number = "10 + 6 x 2"

        let result = count.calculateOperation()

        XCTAssertEqual(result, ["22.0"])
    }

    // Priority operand (division)
    func testGivenPlusAndDivisionOperand_WhenCalculateOperation_ThenDivisionCalculatedFirst() {
        count.number = "10 - 6 / 2"

        let result = count.calculateOperation()

        XCTAssertEqual(result, ["7.0"])
    }

    // Two priority operand, must take the first one, then the second one
    func testGivenTwoPriorityPlusTwoNonPriorityOperand_WhenCalculateOperation_ThenCalculateInOrder() {
        count.number = "10 + 6 x 2 + 18 / 3"

        let result = count.calculateOperation()

        XCTAssertEqual(result, ["28.0"])
    }

    // Correct Expression
    func testGivenCorrectExpression_WhenTestIfExpressionIsCorrect_ThenExpressionIsCorrect() {
        count.number = "10 - 2"

        XCTAssertTrue(count.expressionIsCorrect)
    }

    // Incorrect Expression
    func testGivenIncorrectExpression_WhenTestIfExpressionIsCorrect_ThenExpressionIsIncorrect() {
        count.number = "10 + 2 -"

        XCTAssertFalse(count.expressionIsCorrect)
    }

    // Add an operator
    func testGivenCanAddAnOperator_WhenAddTheOperator_ThenOperatorIsAdded() {
        count.number = "10 + 2"

        XCTAssertTrue(count.expressionIsCorrect)
    }

    // Can't add an operator
    func testGivenCantAddAnOperator_WhenAddTheOperator_ThenOperatorIsNotAdded() {
        count.number = "10 + 2 -"

        XCTAssertFalse(count.expressionIsCorrect)
    }

    // Enough elements
    func testGivenExpressionWithEnoughElements_WhenTestIfEnoughElements_ThenEnoughElements() {
        count.number = "20 + 9"

        XCTAssertTrue(count.expressionHaveEnoughElement)
    }

    // Not enough elements
    func testGivenExpressionWithoutEnoughElements_WhenTestIfEnoughElements_ThenNotEnoughElements() {
        count.number = "20 +"

        XCTAssertFalse(count.expressionHaveEnoughElement)
    }

    // Unknown operand
    func testGivenUnknownOperand_WhenCalculateOperation_ThenReturnNil() {
        count.number = "10 ( 2"

        XCTAssertNil(count.calculateOperation())
    }

    // Adding an operand
    func testGivenOperandToAdd_WhenAddingOperand_ThenOperandIsAdded() {
        count.number.append("3")
        count.addOperand(operand: "-")

        XCTAssertEqual(count.number, "3 - ")
    }

    // Adding a number
    func testGivenNumberToAdd_WhenAddingNumber_ThenNumberIsAdded() {
        count.addNumber(numberToAdd: "8")

        XCTAssertEqual(count.number, "8")
    }

    // Start the operation by an operand
    func testGivenStartingOperationWithOperandFollowedBy3_WhenCalculateOperation_ThenResultIs3AndFirstElementIs0() {
        count.addOperand(operand: "+")
        count.addNumber(numberToAdd: "3")

        let result = count.calculateOperation()

        XCTAssertEqual(count.elements.first, "0")
        XCTAssertEqual(result, ["3.0"])
    }

    // If we want to continue the operation
    func testGivenFinishedOperation_WhenAddingNewElements_ThenOperationContinue() {
        count.number = "20 - 3"
        _ = count.calculateOperation()

        count.number.append(" + 2")
        let result = count.calculateOperation()

        XCTAssertEqual(result, ["19.0"])
    }
}