//
//  APIRequestProvider.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

protocol APIRequestProvider {
    associatedtype Response: Codable
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

extension APIRequestProvider {
    var queryItems: [URLQueryItem] {
        return []
    }
}

extension APIRequestProvider {
    func request(with baseUrl: URL) throws -> URLRequest {
        var urlComponents = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            throw NetworkError.wrongURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
