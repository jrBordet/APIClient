//
//  GetSuccess.swift
//  APIClient_Example
//
//  Created by Jean Raphael on 07/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import APIClient

struct GetCommon: APIRequest {    
    typealias Response = [CommonModel]
    
    var resourceName: String {
        return ""
    }
}
