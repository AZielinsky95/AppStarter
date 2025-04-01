//
//  Networking.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//


import Foundation
import Alamofire

protocol Networking {
    func execute<T: Decodable>(request: RequestProviding) async throws -> T
}

actor API: Networking {

    func execute<T>(request: RequestProviding) async throws -> T where T : Decodable {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                request.requestURLString,
                method: request.method,
                parameters: request.params,
                encoder: JSONParameterEncoder.default,
                headers: request.headers
            )
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let decodedObject = try decoder.decode(T.self, from: data)
                        continuation.resume(returning: decodedObject)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
