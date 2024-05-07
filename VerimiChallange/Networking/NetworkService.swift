//
//  NetworkService.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

protocol NetworkServiceProtocol {
    var baseURL: URL { get set }
    func getData(from apiRequest: some APIRequestProvider) async throws -> Data
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    var baseURL: URL

    init(baseURL: URL = Constants.baseURL,
         session: URLSession = .shared
    ) {
        self.session = session
        self.baseURL = baseURL
    }

    func getData(from requestProvider: some APIRequestProvider) async throws -> Data {
        let urlRequest = try requestProvider.request(with: baseURL)
        let (data, response) = try await session.data(for: urlRequest)
        try NetworkErrorHandler.handleError(for: response)
        return data
    }
}
