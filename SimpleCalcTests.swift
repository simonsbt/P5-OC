//
//  SimpleCalcTests.swift
//  CountOnMeTests
//
//  Created by Simon Sabatier on 24/10/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

    let expression = Expression()
    
    func testGivenExpressionHaveOperator_WhenAddOperator_ThenAlertMessage() {
        
        expression.elements = ["2", "+"]
        XCTAssert(!(expression.canAddOperator))
        
    }
    
    func testGivenDivideByZero_WhenTapEqual_ThenAlertMessage() {
        
        expression.elements = ["2", "/", "0"]
        expression.equalButtonTapped()
        XCTAssert(expression.result == 0.0)
        
    }
    
    func testGivenExpressionIsEmpty_WhenAddOperator_ThenAlertMessage() {
        
        expression.elements = []
        XCTAssert(!(expression.canAddOperator))
        
    }

    func testGivenExpressionNotCorrect_WhenEqualTapped_ThenAlertMessage() {
        
        expression.elements = ["5", "x"]
        XCTAssert(!(expression.expressionIsCorrect))
        
    }
    
    func testGivenExpressionHaveNotEnoughElements_WhenEqualTapped_ThenAlertMessage() {
        
        expression.elements = ["17", "-"]
        XCTAssert(!(expression.expressionHaveEnoughElement))
        
    }
    
    func testGivenMultiplication_WhenEqualTapped_ThenRightResultReturned() {
        
        expression.elements = ["23", "x", "7"]
        expression.equalButtonTapped()
        XCTAssert(expression.result == 161.0)
        
    }
    
    func testGivenDivision_WhenEqualTapped_ThenRightResultReturned() {
        
        expression.elements = ["5", "/", "2"]
        expression.equalButtonTapped()
        XCTAssert(expression.result == 2.5)
        
    }
    
    func testGivenAddition_WhenEqualTapped_ThenRightResultReturned() {
        
        expression.elements = ["5", "+", "17"]
        expression.equalButtonTapped()
        XCTAssert(expression.result == 22.0)
        
    }
    
    func testGivenSubstraction_WhenEqualTapped_ThenRightResultReturned() {
        
        expression.elements = ["32", "-", "13"]
        expression.equalButtonTapped()
        XCTAssert(expression.result == 19.0)
        
    }

    func testGivenComplexOperation_WhenEqualTapped_ThenOperatorPrecedenceRespected() {

        expression.elements = ["5", "x", "7", "+", "18", "/", "3"]
        expression.equalButtonTapped()
        XCTAssert(expression.result == 41.0)
        
    }
}
