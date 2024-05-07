//
//  PhotoRepository.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

protocol PhotoRepositoryProtocol {
    init(apiClient: APIClientProtocol)
    func getPhotos(page: Int, limit: Int) async throws -> [Photo]
}

final class PhotoRepository: PhotoRepositoryProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func getPhotos(page: Int = 1, limit: Int = 60) async throws -> [Photo] {
        let request = PhotosRequest(page: page, limit: limit)
        let photos: PhotosRequest.Response = try await apiClient.get(from: request)
        return photos
    }
}
