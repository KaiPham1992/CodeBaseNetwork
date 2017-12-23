//
//  APIProvider.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/22/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class APIProvider {
    let target: TargetType
    
    init(target: TargetType) {
        self.target = target
    }
    
    func rxRequestObject<T: Mappable>(_: T.Type) -> Observable<T?> {
        return API.shared.rxRequestObject(target: target)
    }
    
    func rxRequestArray<T: Mappable>(_: T.Type) -> Observable<[T]> {
        return API.shared.rxRequestArray(target: target)
    }
}
