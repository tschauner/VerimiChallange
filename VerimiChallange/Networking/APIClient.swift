//
//  APIClient.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

protocol APIClientProtocol {
    func get<T: Codable>(from apiRequest: some APIRequestProvider) async throws -> T
}

final class APIClient: APIClientProtocol {
    private let networkService: NetworkServiceProtocol
    private let decoder: JSONDecoder

    init(networkService: NetworkServiceProtocol = NetworkService(),
         decoder: JSONDecoder = .init()
    ) {
        self.networkService = networkService
        self.decoder = decoder
    }

    func get<T: Codable>(from apiRequest: some APIRequestProvider) async throws -> T {
        let data = try await networkService.getData(from: apiRequest)
        return try decoder.decode(T.self, from: data)
    }
}
