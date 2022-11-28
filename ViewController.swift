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
    
    var expression = Expression()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        var notificationName = Notification.Name(rawValue: "CalculationDone")
        NotificationCenter.default.addObserver(
                self, selector: #selector(addResult),
                name: notificationName, object: nil)
        
        notificationName = Notification.Name(rawValue: "DivideByZero")
        NotificationCenter.default.addObserver(
                self, selector: #selector(divideByZero),
                name: notificationName, object: nil)
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expression.expressionHaveResult {
            expression.expressionHaveResult = false
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        expression.elements = elements
        if expression.expressionHaveResult {
            expression.expressionHaveResult = false
            textView.text = ""
        }
        expression.elements = elements
        if expression.canAddOperator {
            textView.text.append(" + ")
        } else {
            presentAlertVC(message: "Impossible d'ajouter un opérateur !")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        expression.elements = elements
        if expression.expressionHaveResult {
            expression.expressionHaveResult = false
            textView.text = ""
        }
        expression.elements = elements
        if expression.canAddOperator {
            textView.text.append(" - ")
        } else {
            presentAlertVC(message: "Impossible d'ajouter un opérateur !")
        }
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        expression.elements = elements
        if expression.expressionHaveResult {
            expression.expressionHaveResult = false
            textView.text = ""
        }
        expression.elements = elements
        if expression.canAddOperator {
            textView.text.append(" x ")
        } else {
            presentAlertVC(message: "Impossible d'ajouter un opérateur !")
        }
    }
    
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        expression.elements = elements
        if expression.expressionHaveResult {
            expression.expressionHaveResult = false
            textView.text = ""
        }
        expression.elements = elements
        if expression.canAddOperator {
            textView.text.append(" / ")
        } else {
            presentAlertVC(message: "Impossible d'ajouter un opérateur !")
        }
        
    }
    
    @IBAction func tappedAllClearButton(_ sender: UIButton) {
        textView.text = ""
        expression.elements = elements
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        expression.elements = elements
        if expression.expressionHaveResult {
            presentAlertVC(message: "Impossible !")
            return
        }
        
        guard expression.expressionIsCorrect else {
            presentAlertVC(message: "Entrez une expression correcte !")
            return
        }
        
        guard expression.expressionHaveEnoughElement else {
            presentAlertVC(message: "Démarrez un nouveau calcul !")
            return
        }
        
        expression.equalButtonTapped()
    }
    
    @objc func addResult() {
        expression.expressionHaveResult = true
        textView.text.append(" = \(expression.result)")
    }
    
    @objc func divideByZero() {
        presentAlertVC(message: "Impossible de diviser par zéro !")
    }
    
    private func presentAlertVC(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
