//
//  PhotoDataRepositoryTests.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

import XCTest
@testable import VerimiChallange
import SwiftData

final class PhotoDataRepositoryTests: XCTestCase {
    var repository: PhotoDataRepository!
    
    @MainActor
    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: PhotoWrapper.self, configurations: config)
        repository = PhotoDataRepository(modelContext: container.mainContext)
    }

    override func tearDown() {
        repository = nil
    }

    func fetchModels() throws -> [PhotoWrapper] {
        return try repository.fetchModels()
    }

    func test_saveAndFetchPhotos() throws {
        // Given
        let wrapper = Photo.mockPhotos.map { PhotoWrapper(photo: $0) }

        // When
        try repository.saveModels(models: wrapper)
        let models = try fetchModels()

        // Then
        XCTAssertEqual(models.count, 5)
    }

    func test_deletePhoto() throws {
        // Given
        let wrapper = Photo.mockPhotos.map { PhotoWrapper(photo: $0) }

        // When
        try repository.saveModels(models: wrapper)
        let model = try XCTUnwrap(wrapper.last)
        try repository.deletePhoto(model)
        let models = try fetchModels()

        // Then
        XCTAssertEqual(models.count, 4)
    }

    func test_deleteAll() throws {
        // Given
        let wrapper = Photo.mockPhotos.map { PhotoWrapper(photo: $0) }

        // When
        try repository.saveModels(models: wrapper)

        // Then
        XCTAssertEqual(wrapper.count, 5)

        // When
        try repository.deleteAll()
        let models = try repository.fetchModels()

        // Then
        XCTAssertEqual(models.count, 0)
    }

    func test_updateFavorite() throws {
        // Given
        let wrapper = Photo.mockPhotos.map { PhotoWrapper(photo: $0) }

        // When
        try repository.saveModels(models: wrapper)
        let model = try XCTUnwrap(wrapper.last)
        try repository.updateFavorite(model)
        let models = try fetchModels()
        
        // Then
        XCTAssertTrue(models.last?.isFavorite == true)
    }
}
