//
//  MockNetworkService.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

@testable import VerimiChallange
import Foundation

class MockNetworkService: NetworkServiceProtocol {
    var baseURL: URL
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func getData(from apiRequest: some APIRequestProvider) async throws -> Data {
        if let error = error {
            throw error
        }
        guard let data = data else {
            throw NSError(domain: "MockNetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data available"])
        }
        return data
    }
}
