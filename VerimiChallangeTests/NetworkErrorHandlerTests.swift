//
//  NetworkErrorHandlerTests.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

import XCTest
@testable import VerimiChallange

final class NetworkErrorHandlerTests: XCTestCase {

    func test_handleError_validResponse() {
        // Given
        let validResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)!

        // When & Then
        XCTAssertNoThrow(try NetworkErrorHandler.handleError(for: validResponse))
    }

    func test_handleError_invalidResponse() {
        // Given
        let invalidResponse = URLResponse(url: URL(string: "https://example.com")!,
                                          mimeType: nil,
                                          expectedContentLength: 0,
                                          textEncodingName: nil)

        // When & Then
        XCTAssertThrowsError(try NetworkErrorHandler.handleError(for: invalidResponse)) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
        }
    }

    func test_handleError_badServerResponse() {
        // Given
        let badResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                          statusCode: 404,
                                          httpVersion: nil,
                                          headerFields: nil)!

        // When & Then
        XCTAssertThrowsError(try NetworkErrorHandler.handleError(for: badResponse)) { error in
            XCTAssertEqual((error as? NetworkError)?.statusCode, 404)
        }
    }
}
