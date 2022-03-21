//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - OUTLETS & VARIABLES

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operandButtons: [UIButton]!

    var operands: [Character] = ["+", "-", "*", "/"]
    var count = Count()
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }

    // MARK: - SWIFT FUNCTIONS

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - ACTIONS

    @IBAction func clearText(_ sender: UIButton) {
        // When AC is pressed, we should clear the operation
        textView.text = ""
        count.number = ""
    }

    @IBAction func tappedNumberButton(_ sender: UIButton) {

        // First open case, clear the screen
        if textView.text.contains("Welcome") {
            removeWelcomeMessage()
        }

        guard let numberText = sender.title(for: .normal) else {
            return
        }

        // If second condition is empty, that means we added an operand before
        if expressionHaveResult && textView.text.last == nil {
            textView.text = ""
            count.number = ""
        }

        count.addNumber(numberToAdd: numberText)
        textView.text.append(numberText)
    }

    @IBAction func tappedOperandButton(_ sender: UIButton) {
        if textView.text.contains("Welcome") {
            removeWelcomeMessage()
        }

        isTheOperationPossible(button: sender)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard count.expressionIsCorrect else {
            return incorrectExpressionError()
        }

        guard count.expressionHaveEnoughElement else {
            return incorrectExpressionError()
        }

        guard let operationToReduce = count.calculateOperation() else {
            return unknownOperandError()
        }

        textView.text.append(" = \(operationToReduce.first!)")

        // If we continue the operation, we directly save the previous result
        count.number = operationToReduce.first!
    }

    // MARK: - FUNCTIONS

    private func isTheOperationPossible(button: UIButton) {
        if count.expressionIsCorrect {
            switch button.title(for: .normal) {
            case "+":
                textView.text.append(" + ")
            case "-":
                textView.text.append(" - ")
            case "x":
                textView.text.append(" * ")
            case "/":
                textView.text.append(" / ")
            default:
                return unknownOperandError()
            }

            count.addOperand(operand: button.title(for: .normal)!)

        } else {
            print(operandAlreadySet())
        }
    }

    private func removeWelcomeMessage() {
        textView.text = ""
    }

    private func incorrectExpressionError() {
        let alertVC = UIAlertController(
            title: "Zéro!", message: "Error ! Expression can't end with an operand !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    private func notEnoughElementsError() {
        let alertVC = UIAlertController(
            title: "Zéro!", message: "Error ! Expression doesn't have enough elements !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    private func unknownOperandError() {
        let alertVC = UIAlertController(
            title: "Zéro!", message: "Error ! unknown operand !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    private func operandAlreadySet() {
        let alertVC = UIAlertController(
            title: "Zéro!", message: "Error ! An operand is already set !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
