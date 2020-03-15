//
//  AuthLoginValidator.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 23.02.2020.
//

import Validator

class AuthLoginValidator {

    enum LoginValidateError: String, ValidationError {
        var message: String { self.rawValue }
        
        case length
        case latin
    }
    
    static public var loginValidateRules: ValidationRuleSet<String> = {
        let lengthRule = ValidationRuleLength(min: 3, max: 20,
                                              lengthType: .characters,
                                              error: LoginValidateError.length)
        let patternRule = ValidationRulePattern(pattern: "[a-zA-Z]*",
                                                error: LoginValidateError.latin)
        var rules = ValidationRuleSet<String>()
        rules.add(rule: lengthRule)
        rules.add(rule: patternRule)
        return rules
    }()

    enum PasswordValidateError: String, ValidationError {
        var message: String { self.rawValue }
        
        case length
    }
    
    static public var passwordValidateRules: ValidationRuleSet<String> = {
        let lengthRule = ValidationRuleLength(min: 8, max: 20,
                                              lengthType: .characters,
                                              error: PasswordValidateError.length)
        var rules = ValidationRuleSet<String>()
        rules.add(rule: lengthRule)
        return rules
    }()
    
}
