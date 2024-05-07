//
//  NetworkError.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

enum NetworkError: Error, Equatable {
    case general
    case wrongURL
    case invalidResponse
    case badServerResponse(statusCode: Int)

    var statusCode: Int? {
        switch self {
        case .badServerResponse(statusCode: let code):
            return code
        default:
            return nil
        }
    }
}
