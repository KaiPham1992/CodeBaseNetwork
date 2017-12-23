//
//  APIUtilities.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/22/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import Foundation
// Safe String
postfix operator &

postfix func & <T>(element: T?) -> String {
    return (element == nil) ? "" : "\(element!)"
}

postfix func & <T>(element: T) -> String {
    return "\(element)"
}

// Safe Int
postfix operator *

postfix func *<T>(element: T?) -> Int {
    return (element == nil) ? 0: Int("\(element!)")!
}

class APIUtilities {
    /**
     1. input json ["name": "Kai", "age": 10, "email": "kai@vinova.sg"]
     2. output name=Kai&age=10&email=kai@vinova.sg
     */
    class func dictionaryToStringParameter(body: [String: Any]) -> String {
        var result = [String]()
        for (name, value) in body {
            if let nameEncoded = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let valueEncoded = String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                result.append("\(nameEncoded)=\(valueEncoded)")
            }
        }
        let resultStr = result.joined(separator: "&")
        return resultStr
    }
}
