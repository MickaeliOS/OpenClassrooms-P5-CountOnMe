//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operandButtons: [UIButton]!
    
    var operands = ["+", "-", "*", "/"]
    var count = Count()
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clearText(_ sender: UIButton) {
        textView.text = ""
        count.number = ""
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
            count.number = ""
        }
        
        count.addNumber(numberToAdd: numberText)
        textView.text.append(numberText)
    }
    
    @IBAction func tappedOperandButton(_ sender: UIButton) {
        isTheOperationPossible(button: sender)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard count.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard count.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        if let operationsToReduce = count.calculateOperation() {
            
            textView.text.append(" = \(operationsToReduce.first!)")
            
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Error, unknown operand !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
    }

    private func isTheOperationPossible(button: UIButton) {
        if count.canAddOperator {
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
                    let alertVC = UIAlertController(title: "Zéro!", message: "Error, unknown operand !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
            }
            
            count.addOperand(operand: button.title(for: .normal)!)
            
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
