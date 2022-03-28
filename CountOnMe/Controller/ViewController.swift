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

    var continueOperation = false
    var count = Count()

    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }

    // MARK: - SWIFT FUNCTIONS

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - ACTIONS

    @IBAction func clearText(_ sender: UIButton) {
        // When AC button is pressed, we should clear the operation

        textView.text = ""
        count.number = ""
    }

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }

        // First open, clear the screen's welcoming message
        if textView.text.contains("Welcome") {
            removeWelcomeMessage()
        }

        // We need to check if the user is continuing an operation
        didUserFinished()

        // Constructing the operation
        count.addNumber(numberToAdd: numberText)
        textView.text.append(numberText)
    }

    @IBAction func tappedOperandButton(_ sender: UIButton) {
        guard let operandText = sender.title(for: .normal) else {
            return
        }

        if textView.text.contains("Welcome") {
            removeWelcomeMessage()
        }

        /* Here, if we got a result, that means the operation is over but we just tapped
        an operand button, so the operation continue */
        if expressionHaveResult {
            continueOperation = true
        }

        do {
            try count.addOperand(operand: operandText)
            textView.text.append(" " + operandText + " ")
        } catch {
            createError(message: error.localizedDescription)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        continueOperation = false
        print(count.elements)

        do {
            let result = try count.calculateOperation()

            textView.text.append(" = \(result.first!)")

            // If we continue the operation, we directly save the previous result
            count.number = result.first!

        } catch {
            createError(message: error.localizedDescription)

            if error as? EnumErrors == EnumErrors.dividedBy0 {
                textView.text = ""
                count.number = ""
            }
        }

        // These two lines enable the textView's auto scroll
        let range = NSRange(location: textView.text.count - 1, length: 0)
        textView.scrollRangeToVisible(range)
    }

    @IBAction func tappedCommaButton(_ sender: UIButton) {
        if textView.text.contains("Welcome") {
            removeWelcomeMessage()
        }

        do {
            try count.addComma()
            // Testing if the User have finished his operation or not
            didUserFinished()

            // Constructing the operation
            textView.text.append(".")

        } catch {
            createError(message: error.localizedDescription)
        }
    }

    // MARK: - FUNCTIONS

    private func removeWelcomeMessage() {
        textView.text = ""
    }

    private func didUserFinished() {
        // This function will clear the operation if the user finished it

        if expressionHaveResult && continueOperation == false {
            textView.text = ""
            count.number = ""
        }
        return
    }

    private func createError(message: String) {
        let alertVC = UIAlertController(
            title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
