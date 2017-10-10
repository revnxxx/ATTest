//
//  OnlyNumberValidationPattern.swift
//  ATTest
//
//  Created by Revn Revn on 10.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import Foundation
import Validator

public struct OnlyNumberValidationPattern: ValidationPattern {
    
    public init() {
        
    }
    
    public var pattern: String {
        return "[0-9]{1,3}"
    }
}
