//
//  PhotoRepositoryTests.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

import XCTest
@testable import VerimiChallange

final class PhotoRepositoryTests: XCTestCase {
    var mockApiClient: MockAPIClient!
    var photosRepository: PhotoRepository!

    override func setUp() {
        mockApiClient = MockAPIClient()
        photosRepository = PhotoRepository(apiClient: mockApiClient)
    }

    override func tearDown() {
        mockApiClient = nil
        photosRepository = nil
    }

    func test_fetchPhotos() async throws {
        // Given
        let jsonString = "[{\"id\":1,\"albumId\":1,\"title\":\"Test Photo\",\"url\":\"https://example.com/photo.jpg\",\"thumbnailUrl\":\"https://example.com/thumb.jpg\"}]"
        mockApiClient.mockData = Data(jsonString.utf8)

        // When
        let photos = try await photosRepository.getPhotos()

        // Then
        XCTAssertNotNil(photos)
        XCTAssertEqual(photos.count, 1)
        XCTAssertEqual(photos.first?.title, "Test Photo")
    }

    func test_fetchPhotos_shouldFail() async {
        // Given
        mockApiClient.shouldReturnError = true

        do {
            // When
            let _ = try await photosRepository.getPhotos()
            XCTFail("Expected failure but succeeded")
        } catch {
            // Then
            XCTAssertNotNil(error)
        }
    }
}
