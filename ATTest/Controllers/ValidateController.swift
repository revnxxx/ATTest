//
//  ValidateController.swift
//  ATTest
//
//  Created by Revn Revn on 10.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import Foundation
import Validator

class ValidateController {
    
    private let ERROR_MESSEGE = "Номер ID должен быть между 1 и "
    
    func check(userInputData: String, maxInputId: Int) -> (id: Int?, error: ValidationError?) {
        let digitRule = ValidationRulePattern(pattern: OnlyNumberValidationPattern(), error: ValidationError(message: ERROR_MESSEGE + "\(maxInputId)"))
        
        let resultOfDigitRule = userInputData.validate(rule: digitRule)
        
        switch resultOfDigitRule {
        case .valid: break
        case .invalid(let failures): 
        return (nil, failures.first as? ValidationError)
        }
        let postId: Int = Int(userInputData)!
        var comparisonRules = ValidationRuleSet<Int>()
        let comparisonRule = ValidationRuleComparison<Int>(min: 1, max: maxInputId, error: ValidationError(message: ERROR_MESSEGE +  "\(maxInputId)"))
        comparisonRules.add(rule: comparisonRule)
        let resultOfComparisonRules = postId.validate(rules: comparisonRules)
        
        switch resultOfComparisonRules {
        case .valid: break
        case .invalid(let failures):
            return (nil, failures.first as? ValidationError)
        }
        return (postId, nil)
    }
}
