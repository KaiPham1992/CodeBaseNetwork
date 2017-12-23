//
//  ApiError.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/22/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import Foundation
import ObjectMapper

class StatusError: Mappable {
    var statusCode: Int?
    var status: Bool?
    var message: String?
    
    func mapping(map: Map) {
        self.statusCode <- map["code"]
        self.status <- map["status"]
        self.message <- map["message"]
    }
    
    required init?(map: Map) {
        
    }
    
}

enum ApiError: Error {
    case requestFormatError(Error)
    case errorFromAPI(statusError: StatusError?)
    
    var errorDescription: String {
        switch self {
            case .requestFormatError(let e): return e.localizedDescription
        case .errorFromAPI(let statusError):
            guard let _error = statusError else { return "Error nil !"}
            return "\(_error.statusCode*): \(_error.message&)"
        }
    }
}
