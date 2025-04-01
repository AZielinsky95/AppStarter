//
//  RequestProviding.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//


import Alamofire
import AnyCodable

protocol RequestProviding {
    var baseURLString: String { get }
    var endPoint: String { get }
    var headers: HTTPHeaders? { get }
    var params: [String: AnyEncodable]? { get }
    var method: HTTPMethod { get }
    
    var requestURLString: String { get }
}

extension RequestProviding {
    var baseURLString: String {
        isSimulator ? "http://localhost:8000" : "http://192.168.1.172:8000"
    }
    
    var requestURLString: String {
        baseURLString + "/" + endPoint
    }
}

let isSimulator: Bool = {
    #if targetEnvironment(simulator)
    return true
    #else
    return false
    #endif
}()
