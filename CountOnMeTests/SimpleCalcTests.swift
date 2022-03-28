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
    func testGivenPlusAndMultiplication_WhenCalculateOperation_ThenMultiplicationCalculatedFirst() {
        count.number = "10 + 6 x 2"

        XCTAssertEqual(try? count.calculateOperation(), ["22"])
    }

    // Priority operand (division)
    func testGivenPlusAndDivisionOperand_WhenCalculateOperation_ThenDivisionCalculatedFirst() {
        count.number = "10 + 6 / 2"

        XCTAssertEqual(try? count.calculateOperation(), ["13"])
    }

    // Two priority operand, must take the first one, then the second one
    func testGivenTwoPriorityPlusTwoNonPriorityOperand_WhenCalculateOperation_ThenCalculateInOrder() {
        count.number = "10 + 6 x 2 + 18 / 3"

        XCTAssertEqual(try? count.calculateOperation(), ["28"])
    }

    // Correct Expression
    func testGivenCorrectExpression_WhenTestIfExpressionIsCorrect_ThenExpressionIsCorrect() {
        count.number = "10 - 2"

        XCTAssertTrue(count.expressionIsCorrect)
    }

    // Incorrect Expression
    func testGivenIncorrectExpression_WhenTestIfExpressionIsCorrect_ThenExpressionIsIncorrect() {
        count.number = "10 + 2 -"

        XCTAssertThrowsError(try count.calculateOperation()) { (error) in
            XCTAssertEqual(error as? EnumErrors, EnumErrors.incorrectExpression)
        }
    }

    // Add an operator
    func testGivenCanAddAnOperator_WhenAddTheOperator_ThenOperatorIsAdded() {
        count.number = "10"

        XCTAssertNoThrow(try count.addOperand(operand: "+"))
        XCTAssertEqual(count.elements[1], "+")
    }

    // Can't add an operator
    func testGivenCantAddAnOperator_WhenAddTheOperator_ThenOperatorIsNotAdded() {
        count.number = "10 + 2 -"

        XCTAssertThrowsError(try count.addOperand(operand: "+")) { (error) in
            XCTAssertEqual(error as? EnumErrors, EnumErrors.operandAlreadySet)
        }

        XCTAssertTrue(count.elements.count == 4)
    }

    // Enough elements
    func testGivenExpressionWithEnoughElements_WhenTestIfEnoughElements_ThenEnoughElements() {
        count.number = "20 + 9"

        XCTAssertTrue(count.expressionHaveEnoughElement)
    }

    // Not enough elements
    func testGivenExpressionWithoutEnoughElements_WhenTestIfEnoughElements_ThenNotEnoughElements() {
        count.number = "20"

        XCTAssertThrowsError(try count.calculateOperation()) { (error) in
            XCTAssertEqual(error as? EnumErrors, EnumErrors.notEnoughElements)
        }
    }

    // Unknown operand when calculating
    func testGivenUnknownOperand_WhenCalculateOperation_ThenThrowUnknownOperand() {
        count.number = "10 ( 2"

        XCTAssertThrowsError(try count.calculateOperation()) { (error) in
            XCTAssertEqual(error as? EnumErrors, EnumErrors.unknownOperand)
        }
    }

    // Unknown operand when adding
    func testGivenUnknownOperand_WhenAddingOperand_ThenThrowUnknownOperand() {
        count.number = "10"

        XCTAssertThrowsError(try count.addOperand(operand: "(")) { (error) in
            XCTAssertEqual(error as? EnumErrors, EnumErrors.unknownOperand)
        }
    }

    // Adding an operand
    func testGivenOperandToAdd_WhenAddingOperand_ThenOperandIsAdded() {
        count.number.append("3")

        XCTAssertNoThrow(try count.addOperand(operand: "-"))

        XCTAssertEqual(count.number, "3 - ")
    }

    // Adding a number
    func testGivenNumberToAdd_WhenAddingNumber_ThenNumberIsAdded() {
        count.addNumber(numberToAdd: "8")

        XCTAssertEqual(count.number, "8")
    }

    // Start the operation by an operand add a 0 at the beggining
    func testGivenStartingOperationWithOperandFollowedBy3_WhenCalculateOperation_ThenResultIs3AndFirstElementIs0() {
        XCTAssertNoThrow(try count.addOperand(operand: "+"))
        count.addNumber(numberToAdd: "3")

        XCTAssertEqual(try? count.calculateOperation(), ["3"])
        XCTAssertEqual(count.elements.first, "0")
    }

    // If we want to continue the operation
    func testGivenFinishedOperation_WhenAddingNewElements_ThenOperationContinue() {
        count.number = "20 - 3"
        XCTAssertNoThrow(try count.calculateOperation())

        count.number.append(" + 2")

        XCTAssertEqual(try? count.calculateOperation(), ["19"])
    }

    // Division by 0
    func testGivenADivisionBy0_WhenCalculateOperation_ThenReturnDividedBy0() {
        count.number = "20 / 0"

        XCTAssertThrowsError(try count.calculateOperation()) { (error) in
            XCTAssertEqual(error as? EnumErrors, EnumErrors.dividedBy0)
        }
    }

    // Operation with Comma works
    func testGivenCorrectCommaOperation_WhenCalculateOperation_ThenOperationSuccess() {
        count.number = "20.1 + 3.8"

        XCTAssertEqual(try? count.calculateOperation(), ["23.9"])
    }

    // Can't add comma twice
    func testGivenOperationWithComma_WhenAddAnotherCommaInARow_ThenExepressionAlreadyHaveCommaIsTrue() {
        count.number = "20."

        XCTAssertThrowsError(try count.addComma()) { (error) in
            XCTAssertEqual(error as? EnumErrors, EnumErrors.doubleComma)
        }
    }

    // Adding comma works
    func testGivenAnOperation_WhenAddingComma_ThenCommaIsAdded() {
        count.number = "3 + 1"

        XCTAssertNoThrow(try? count.addComma())

        XCTAssertEqual(count.number, "3 + 1.")
    }

    // Can't add a comma if last element is an operand
    func testGivenAnExpressionWithOperandInLastPosition_WhenAddingComma_ThenCommaCantBeAdded() {
        count.number = "3 +"

        XCTAssertThrowsError(try count.addComma()) { (error) in
            XCTAssertEqual(error as? EnumErrors, EnumErrors.cantAddComma)
        }
    }
}
