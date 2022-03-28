//
//  EnumErrors.swift
//  CountOnMe
//
//  Created by Mickaël Horn on 28/03/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum EnumErrors: Error {
    case unknownOperand, operandAlreadySet, dividedBy0, cantAddComma, doubleComma
    case incorrectExpression, notEnoughElements
}

extension EnumErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownOperand:
            return NSLocalizedString(
                "Error ! unknown operand !",
                comment: ""
            )
        case .operandAlreadySet:
            return NSLocalizedString(
                "Error ! An operand is already set !",
                comment: ""
            )
        case .dividedBy0:
            return NSLocalizedString(
                "Error ! You can't divide by 0 !",
                comment: ""
            )
        case .cantAddComma:
            return NSLocalizedString(
                "Error ! You can't type comma right after an operand !",
                comment: ""
            )
        case .doubleComma:
            return NSLocalizedString(
                "Error ! You can't type comma twice in a row !",
                comment: ""
            )
        case .incorrectExpression:
            return NSLocalizedString(
                "Error ! Expression must end with a number !",
                comment: ""
            )
        case .notEnoughElements:
            return NSLocalizedString(
                "Error ! Expression doesn't have enough elements !",
                comment: ""
            )
        }
    }
}
