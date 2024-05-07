//
//  APIClientTests.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

import XCTest
@testable import VerimiChallange

final class APIClientTests: XCTestCase {
    var sut: APIClient!
    var mockNetworkService: MockNetworkService!
    var decoder: JSONDecoder!

    override func setUp() {
        let testBaseURL = URL(string: "https://test.example.com")!
        mockNetworkService = MockNetworkService(baseURL: testBaseURL)
        decoder = JSONDecoder()
        sut = APIClient(networkService: mockNetworkService, decoder: decoder)
    }

    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        decoder = nil
    }

    func testAPIClient_SuccessfulFetch() async {
        // Given
        let jsonString = """
        {
        "id": 1,
        "albumId": 101,
        "title": "A Test Photo",
        "url": "https://example.com/photo.jpg",
        "thumbnailUrl": "https://example.com/thumb.jpg"
        }
        """
        mockNetworkService.data = Data(jsonString.utf8)

        do {
            // When
            let result: Photo = try await sut.get(from: MockPhotoRequest())

            // Then
            XCTAssertEqual(result.id, 1)
            XCTAssertEqual(result.title, "A Test Photo")
            XCTAssertEqual(mockNetworkService.baseURL.absoluteString, "https://test.example.com")
        } catch {
            XCTFail("Expected successful decoding, but failed with \(error)")
        }
    }

    func testAPIClient_Failure() async {
        // Given
        mockNetworkService.error = NSError(domain: "TestError", code: 1, userInfo: nil)

        do {
            // When
            let _: Photo = try await sut.get(from: MockPhotoRequest())
            XCTFail("Expected failure, but succeeded")
        } catch {
            // Then
            XCTAssertNotNil(error)
        }
    }
}
