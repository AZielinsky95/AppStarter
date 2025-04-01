//
//  GetAccountsRequest.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//


import Alamofire
import AnyCodable

struct ExampleRequest: RequestProviding {
    
    var endPoint: String {
        "api/v1/example"
    }
    
    var headers: HTTPHeaders? { [.init(name: "Content-Type", value: "application/json")] }
    
    var params: [String : AnyEncodable]?
    
    var method: HTTPMethod {
        .get
    }
}
