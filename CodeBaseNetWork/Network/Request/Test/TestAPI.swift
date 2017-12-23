//
//  TestAPI.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/22/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import Foundation

enum TestAPI {
    case getAllWordbook()
    case getWordbookWith(id: String)
}

extension TestAPI: TargetType {
    var baseURL: String {
        return baseUrlAPI
    }
    
    var path: String? {
        switch self {
        case .getAllWordbook:
            return "api/v1/wordbook"
        case .getWordbookWith(let id):
            return "api/v1/wordbook/\(id)"
        }
        
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllWordbook, .getWordbookWith:
           return HTTPMethod.get
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var parametersEncoding: ParameterEncoding? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
