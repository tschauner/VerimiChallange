//
//  MockPhotoRepository.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

import XCTest
@testable import VerimiChallange

final class MockPhotoRepository: PhotoRepositoryProtocol {
    private let apiClient: VerimiChallange.APIClientProtocol
    var expectation: XCTestExpectation?
    var shouldFail = false
    var photos: [Photo] = []

    init(apiClient: VerimiChallange.APIClientProtocol) {
        self.apiClient = apiClient
    }

    func getPhotos(page: Int, limit: Int) async throws -> [VerimiChallange.Photo] {
        defer {
            expectation?.fulfill()
        }

        if shouldFail {
            throw NetworkError.general
        } else {
            return photos
        }
    }
}
