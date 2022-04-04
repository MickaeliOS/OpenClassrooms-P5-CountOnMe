//
//  Count.swift
//  CountOnMe
//
//  Created by Mickaël Horn on 07/03/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Count {

    // MARK: - VARIABLES
    var number = ""
    var elements: [String] {
        return number.split(separator: " ").map { "\($0)" }
    }

    var expressionIsCorrect: Bool {
        return elements.last != "+"
        && elements.last != "-"
        && elements.last != "x"
        && elements.last != "/"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    // MARK: - FUNCTIONS

    func calculateOperation() throws -> [String] {
        /* This function will calculate the operation.
         Furthermore, it will call a function to find operation priorities */

        if !expressionIsCorrect {
            throw EnumErrors.incorrectExpression
        }

        if !expressionHaveEnoughElement {
            throw EnumErrors.notEnoughElements
        }

        // Create local copy of elements because it's a "get-only" property
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {

            // Here, we get the index where the priority is
            let index = findPriority(operation: operationsToReduce)

            let left = Double(operationsToReduce[index-1])!
            let operand = operationsToReduce[index]
            let right = Double(operationsToReduce[index+1])!

            let result: Double

            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/":
                if right != 0 {
                    result = left / right
                } else {
                    throw EnumErrors.dividedBy0
                }
            default: throw EnumErrors.unknownOperand
            }

            // We don't need the first 3 elements, so we delete them in order to add the result of these 3 elements
            operationsToReduce.removeSubrange(index-1...index+1)

            // In term of precision, we want 2 digits after comma
            let roundedResult = round(result * 100) / 100.0

            // If result is a whole number, let's make it an integer for printing clarity
            let isInteger = isInteger(number: roundedResult)

            operationsToReduce.insert("\(isInteger)", at: index-1)
        }
        return operationsToReduce
    }

    func addNumber(numberToAdd: String) {
        number.append(numberToAdd)
    }

    private func findPriority(operation: [String]) -> Int {
        // Here, we will check for priority operands in order

        let multiplication = operation.contains("x")
        let division = operation.contains("/")

        switch true {
        case multiplication && division:
            let multiplicationIndex = operation.firstIndex(of: "x")!
            let divisionIndex = operation.firstIndex(of: "/")!

            // We need to retrieve the first priority
            return min(multiplicationIndex, divisionIndex)

        case multiplication && !division:
            return operation.firstIndex(of: "x")!

        case !multiplication && division:
            return operation.firstIndex(of: "/")!

        default:
            return 1
        }
    }

    private func isInteger(number: Double) -> Any {
        /* If number is a whole number, let's make it an integer for printing clarity
         Otherwise, we just return the number itself */

        let flooredNumber = floor(number)

        if flooredNumber == number {
            return Int(flooredNumber)
        }

        return number
    }

    func addOperand(operand: String) throws {
        if !expressionIsCorrect {
            throw EnumErrors.operandAlreadySet
        }

        switch operand {
        case "+", "-", "x", "/":

            // If we start the operation with an operand, insert 0 first
            if elements.count == 0 {
                number.append("0")
            }
            number.append(" " + operand + " ")
        default:
            throw EnumErrors.unknownOperand
        }
    }

    func addComma() throws {
        if !expressionIsCorrect {
            throw EnumErrors.cantAddComma
        }

        if elements.last?.last == "." {
            throw EnumErrors.doubleComma
        }

        if let result = (elements.last?.contains(".")), result == true {
            throw EnumErrors.commaAlreadySet
        }
        number.append(".")
    }
}
