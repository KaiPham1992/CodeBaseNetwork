//
//  ParameterEncoding.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/22/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import Foundation

enum ParameterEncoding {
    case formURL, json
    func encode(body: [String: Any]) -> Data? {
        switch self {
        case .formURL:
            return APIUtilities.dictionaryToStringParameter(body: body).data(using: .utf8)
        case .json :
            return try? JSONSerialization.data(withJSONObject: body)
        }
    }
    
    var contentType: String? {
        switch self {
        case .formURL:
            return "application/x-www-form-urlencoded"
        case .json:
            return "application/json; charset=utf-8"
        }
    }
}
