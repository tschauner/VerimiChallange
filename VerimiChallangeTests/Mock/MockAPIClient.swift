//
//  MockAPIClient.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

import XCTest
@testable import VerimiChallange

final class MockAPIClient: APIClientProtocol {
    var shouldReturnError: Bool = false
    var mockData: Data?

    func get<T>(from apiRequest: some VerimiChallange.APIRequestProvider) async throws -> T where T : Decodable, T : Encodable {
        guard !shouldReturnError else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        }

        guard let data = mockData else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No mock data available"])
        }

        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Decoding failed"])
        }
    }
}
