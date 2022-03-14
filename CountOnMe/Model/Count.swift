//
//  Count.swift
//  CountOnMe
//
//  Created by Mickaël Horn on 07/03/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Count {
    var number = ""
    var elements: [String] {
        return number.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    func calculateOperation() -> [String]? {
        
        // Create local copy of operations
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
            
            operationsToReduce.removeSubrange(index-1...index+1)
            operationsToReduce.insert("\(result)", at: index-1)
        }
        
        return operationsToReduce
    }
    
    func addNumber(numberToAdd: String) {
        number.append(numberToAdd)
    }
    
    func addOperand(operand: String) {
        number.append(" " + operand + " ")
    }
    
    private func findPriority(operation: [String]) -> Int {
        
        if operation.contains("x") && operation.contains("/") {
            
            let multiplication = operation.firstIndex(of: "x")!
            let division = operation.firstIndex(of: "/")!
            
            return min(multiplication, division)
            
        } else if operation.contains("x") && !operation.contains("/") { return operation.firstIndex(of: "x")!
        } else if !operation.contains("x") && operation.contains("/") { return operation.firstIndex(of: "/")!
        } else { return 1 }
    }
}
