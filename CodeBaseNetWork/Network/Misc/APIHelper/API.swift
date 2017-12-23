//
//  API.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/22/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import SwiftyJSON

class API {
    static let shared = API()
    private lazy var session: URLSession = URLSession.shared
    
    func rxRequestObject<T: Mappable>(target: TargetType) -> Observable<T?> {
        return Observable.create({ observer -> Disposable in
            self.rxRequestJSON(target: target).subscribe(onNext: { json in
                let object = Mapper<T>().map(JSONObject: json.dictionaryObject)
                observer.onNext(object)
                observer.onCompleted()
            }, onError: { error in
                observer.onError(error)
            }, onCompleted: {
                observer.onCompleted()
            })
            
            return Disposables.create()
        })
    }
    
    func rxRequestArray<T: Mappable>(target: TargetType) -> Observable<[T]> {
        return Observable.create({ observer -> Disposable in
            self.rxRequestJSON(target: target).subscribe(onNext: { json in
                let objects = Mapper<T>().mapArray(JSONObject: json.arrayObject) ?? []
                observer.onNext(objects)
                observer.onCompleted()
            }, onError: { error in
                observer.onError(error)
            }, onCompleted: {
                observer.onCompleted()
            })
            
            return Disposables.create()
        })
    }
    
    
}

// MARK: handle response
extension API {
    /**
     1. create URLRequest
     2. if URLRequest != nil (flatMap), excute request to receive response
     3. handle when success, error ...
     */
    private func rxRequestJSON(target: TargetType) -> Observable<JSON> {
        return Observable.create({ observer -> Disposable in
            URLRequest.request(target: target)
                .flatMap { self.session.rx.response(request: $0) }
                .subscribe(onNext: { response, data in
                    let json = JSON(data)
                    let jsonStatus = json[APIKeyParam.status.rawValue]
                    let statusError = Mapper<StatusError>().map(JSONObject: jsonStatus.dictionaryObject)
                    
                    //---
                    if statusError!.statusCode* >= 200 || statusError!.statusCode* < 300 {
                        let jsonData = json[APIKeyParam.data.rawValue]
                        observer.onNext(jsonData)
                        observer.onCompleted()
                    } else {
                        observer.onError(ApiError.errorFromAPI(statusError: statusError))
                    }
                }, onError: { error in
                    observer.onError(ApiError.requestFormatError(error))
                }, onCompleted: {
                    observer.onCompleted()
                })
            
            return Disposables.create()
        })
        
        
    }
}
