//
//  ValidationError.swift
//  ATTest
//
//  Created by Revn Revn on 10.10.17.
//  Copyright © 2017 Revn Revn. All rights reserved.
//

import Foundation

struct ValidationError: Error {
    
    public let message: String
    
    public init(message m: String) {
        message = m
    }
}
