//
//  TestModel.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/23/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import Foundation
import ObjectMapper

class TestModel: Mappable {
    var idWordBook: String?
    var nameWordBook: String?
    
    func mapping(map: Map) {
        self.idWordBook <- map["idWordBook"]
        self.nameWordBook <- map["nameWordBook"]
    }
    
    required init?(map: Map) {
        
    }
    
    
}
