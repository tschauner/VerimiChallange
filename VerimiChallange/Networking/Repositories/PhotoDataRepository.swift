//
//  PhotoDataRepository.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import SwiftData
import Foundation

protocol PhotoDataRepositoryProtocol: DataServiceProtocol {
    func fetchModels(pageSize: Int?, page: Int?) throws -> [PhotoWrapper]
    func saveModels(models: [PhotoWrapper]) throws
    func deletePhoto(_ photo: PhotoWrapper) throws
    func deleteAll() throws
    func updateFavorite(_ photo: PhotoWrapper) throws
}

extension PhotoDataRepositoryProtocol {
    func fetchModels(pageSize: Int? = nil, page: Int? = nil) throws -> [PhotoWrapper] {
        var fetchDescriptor = FetchDescriptor<PhotoWrapper>()
        if let pageSize, let page {
            fetchDescriptor.fetchLimit = pageSize
            fetchDescriptor.fetchOffset = page * pageSize
        }
        fetchDescriptor.sortBy = [.init(\.id, order: .forward)]
        let models = try fetch(fetchDescriptor)
        return models
    }

    func saveModels(models: [PhotoWrapper]) throws {
        for model in models {
            insert(model)
        }
        try saveChanges()
    }

    func deletePhoto(_ photo: PhotoWrapper) throws {
        delete(photo)
        try modelContext.saveChanges()
    }

    func deleteAll() throws {
        try delete(model: PhotoWrapper.self)
        try saveChanges()
    }

    func updateFavorite(_ photo: PhotoWrapper) throws {
        photo.isFavorite.toggle()
        try saveChanges()
    }
}

final class PhotoDataRepository: PhotoDataRepositoryProtocol {
    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}
