//
//  MockPhotoRequest.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

import Foundation
@testable import VerimiChallange

struct MockPhotoRequest: APIRequestProvider {
    typealias Response = [Photo]

    var path: String { "/photos" }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem] { [] }
}
