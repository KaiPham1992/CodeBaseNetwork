//
//  TargetType.swift
//  CodeBaseNetWork
//
//  Created by Kai Pham on 12/22/17.
//  Copyright © 2017 Kai Pham. All rights reserved.
//

import Foundation

let baseUrlAPI = "http://192.168.1.3:3000/"
let ContentTypeAPI = "Content-Type"

protocol TargetType {
    var baseURL: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var parametersEncoding: ParameterEncoding? { get }
    var headers: [String: String]? { get }
    //var multipartBody: [MultipartFormData]? { get }
}
