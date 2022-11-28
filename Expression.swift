//
//  Expression.swift
//  CountOnMe
//
//  Created by Simon Sabatier on 14/11/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Expression {
    
    var elements: [String] = []
    var expressionHaveResult = true
    var result: Double = 0.0
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        let lastElementIsCorrect = elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
        return lastElementIsCorrect
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        if elements.count <= 0 {
            return false
        } else {
            let lastElement = elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x"
            
            return lastElement
        }
    }
    
    func equalButtonTapped() {
        
        // Create local copy of operations
        var operationsToReduce = elements

        
        var stringNumbers = [String]()
        var operators = [String]()
        let initial = Double(operationsToReduce.first!)!
        
        // remove the inital number
        operationsToReduce.remove(at: 0)
        
        for element in operationsToReduce {
            if let _ = Double(element) { // if the current element is a Double
                stringNumbers.append(element) // add it to the array of string numbers
            } else {
                operators.append(element) // else add it to the array of operators
            }
        }
        
        result = calculateTotal(stringNumbers: stringNumbers, operators: operators, initial: initial)
        
        // Notify the ViewController that the calculation is done
        let name = Notification.Name(rawValue: "CalculationDone")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
    
    // func to calculate the given expression
    private func calculateTotal(stringNumbers: [String], operators: [String], initial: Double) -> Double {

        // depending on the pendingOperator, add or substract the total to the pendingNumber
        func performPendingOperation(pendingNumber: Double, pendingOperator: String, total: Double) -> Double {
            
            switch pendingOperator {
            case "+":
                return pendingNumber + total
            case "-":
                return pendingNumber - total
            default:
                return total
            }
        }
        
        
        var total = initial
        var pendingNumber = 0.0
        var pendingOperator = ""

        // loop through the stringNumbers array and keep the index i
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) { // check if the stringNumber item is a Double and store it
                switch operators[i] { // check the operator at the same index as the number
                case "+":
                    total = performPendingOperation(pendingNumber: pendingNumber, pendingOperator: pendingOperator, total: total) //calculate the pending operation if there's one
                    pendingNumber = total // store the total returned by the previous instruction
                    pendingOperator = "+" // store the operator
                    total = number // store the number
                    
                case "-":
                    total = performPendingOperation(pendingNumber: pendingNumber, pendingOperator: pendingOperator, total: total) //calculate the pending operation if there's one
                    pendingNumber = total // store the total returned by the previous instruction
                    pendingOperator = "-" // store the operator
                    total = number // store the number
                    
                case "/":
                    if number == 0 { // if we try to divide by 0, create post a Notification to display the alert and set the result to 0
                        let name = Notification.Name(rawValue: "DivideByZero")
                        let notification = Notification(name: name)
                        NotificationCenter.default.post(notification)
                        return 0.0
                    } else {
                        total /= number
                    }
                case "x":
                    total *= number
                default:
                    break
                }
            }
        }

        // perform final pending operation if needed
        total = performPendingOperation(pendingNumber: pendingNumber, pendingOperator: pendingOperator, total: total)

        return total
    }
}
