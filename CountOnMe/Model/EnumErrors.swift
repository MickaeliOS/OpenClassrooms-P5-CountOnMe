//
//  EnumErrors.swift
//  CountOnMe
//
//  Created by Mickaël Horn on 28/03/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum EnumErrors: Error {
    case unknownOperand,
         operandAlreadySet,
         dividedBy0,
         cantAddComma,
         doubleComma,
         incorrectExpression,
         notEnoughElements,
         commaAlreadySet
}

extension EnumErrors: LocalizedError {
    var errorDescription: String? {

        switch self {
        case .unknownOperand:
            return NSLocalizedString(
                "unknown operand!",
                comment: ""
            )
        case .operandAlreadySet:
            return NSLocalizedString(
                "An operand is already set!",
                comment: ""
            )
        case .dividedBy0:
            return NSLocalizedString(
                "You can't divide by 0!",
                comment: ""
            )
        case .cantAddComma:
            return NSLocalizedString(
                "You can't type comma right after an operand!",
                comment: ""
            )
        case .doubleComma:
            return NSLocalizedString(
                "You can't type comma twice in a row!",
                comment: ""
            )
        case .incorrectExpression:
            return NSLocalizedString(
                "Expression must end with a number!",
                comment: ""
            )
        case .notEnoughElements:
            return NSLocalizedString(
                "Expression doesn't have enough elements!",
                comment: ""
            )
        case .commaAlreadySet:
            return NSLocalizedString(
                "You already put a comma!",
                comment: ""
            )
        }
    }
}
