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
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    // MARK: - FUNCTIONS

    func calculateOperation() -> [String]? {
        /* This function will calculate the operation.
         Furthermore, it will call the function to find operation priorities */

        // Create local copy of elements because it's a "get-only" property
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {

            let index = findPriority(operation: operationsToReduce)

            let left = Float(operationsToReduce[index-1])!
            let operand = operationsToReduce[index]
            let right = Float(operationsToReduce[index+1])!

            let result: Float

            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: return nil
            }

            // We don't need the first 3 elements, so we delete them in order to add the result of these 3 elements
            operationsToReduce.removeSubrange(index-1...index+1)
            operationsToReduce.insert("\(result)", at: index-1)
        }

        return operationsToReduce
    }

    func addNumber(numberToAdd: String) {
        number.append(numberToAdd)
    }

    func addOperand(operand: String) {
        if elements.count == 0 {
            number.append("0")
        }
        number.append(" " + operand + " ")
    }

    private func findPriority(operation: [String]) -> Int {
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
}
