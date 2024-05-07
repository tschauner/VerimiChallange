//
//  PhotosRequest.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

struct PhotosRequest: APIRequestProvider {
    typealias Response = [Photo]
    let page: Int
    var limit: Int

    var path: String {
        "photos"
    }

    var method: HTTPMethod { .get }

    var queryItems: [URLQueryItem] { 
        [URLQueryItem(name: "_page", value: "\(page)"),
        URLQueryItem(name: "_limit", value: "\(limit)")]
    }
}
