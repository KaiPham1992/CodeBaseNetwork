//
//  URLRequest+extension.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/22/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import RxSwift
/**
 1.This class to create Observable<URLRequest>
 */

extension URLRequest {
    static func request(target: TargetType) -> Observable<URLRequest> {
        var request = createRequest(target: target)
        request.httpMethod = target.method.description
        
        //---
        if let headers = target.headers {
            for (k, v) in headers {
                request.addValue(v, forHTTPHeaderField: k)
            }
        }
        
        return Observable.just(request)
    }
}

// MARK: Create URLRequest
extension URLRequest {
    static private func createRequest(target: TargetType) -> URLRequest {
        var strUrl = "\(target.baseURL)\(target.path&)"
        
        switch target.method {
        case .put, .post, .patch:
            //---
            guard let url = URL(string: strUrl) else {
                return URLRequest(url: URL(fileURLWithPath: ""))
            }
            
            var request = URLRequest(url: url)
            guard let encoding = target.parametersEncoding else { return request }
            
            request.addValue(encoding.contentType&, forHTTPHeaderField: ContentTypeAPI)
            
            //---
            if let param = target.parameters {
                request.httpBody = encoding.encode(body: param)
            }
            
            return request
        case .get, .delete, .options:
            //---
            if let _param = target.parameters {
                let param = APIUtilities.dictionaryToStringParameter(body: _param)
                if !param.isEmpty {
                    strUrl = "\(strUrl)?\(param)"
                }
            }
            
            //---
            guard let url = URL(string: strUrl) else {
                return URLRequest(url: URL(fileURLWithPath: ""))
            }
            return URLRequest(url: url)
        }
    }
}
