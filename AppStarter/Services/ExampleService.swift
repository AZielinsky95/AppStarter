//
//  BentoServicing.swift
//  AppStarter
//
//  Created by Alejandro Zielinsky on 2025-03-30.
//


import Combine

protocol ExampleServicing {
    var api: Networking { get }
    func getThis() async throws -> ExampleResponse
    func postThat() async throws -> ExampleResponse
}

struct ExampleService: ExampleServicing {
    let api: Networking
    
    func getThis() async throws -> ExampleResponse {
        let request = ExampleRequest()
        return try await api.execute(request: request)
    }
    
    func postThat() async throws -> ExampleResponse {
        return ExampleResponse(returnedData: [])
    }
}
