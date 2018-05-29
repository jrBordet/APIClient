//
//  result.swift
//  APIClientTutorial
//
//  Created by Jean Raphael on 14/02/2018.
//  Copyright © 2018 Jean Raphael Bordet. All rights reserved.
//

import Foundation

//https://github.com/antitypical/Result

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

public typealias ResultCallback<Value> = (Result<Value>) -> Void
