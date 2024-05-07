//
//  NetworkErrorHandler.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

struct NetworkErrorHandler {
    static func handleError(for response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.badServerResponse(statusCode: httpResponse.statusCode)
        }
    }
}
