//
//  PhotoViewModelTests.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 03.05.24.
//

import XCTest
import SwiftData
@testable import VerimiChallange

final class PhotoViewModelTests: XCTestCase {
    var sut: PhotosViewModel!
    var repository: MockPhotoRepository!
    var dataRepository: MockPhotoDataRepository!
    var apiClient: MockAPIClient!

    @MainActor 
    override func setUpWithError() throws {
        apiClient = MockAPIClient()
        repository = MockPhotoRepository(apiClient: apiClient)

        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: PhotoWrapper.self, configurations: config)

        dataRepository = MockPhotoDataRepository(modelContext: container.mainContext)
        sut = .init(photoRepository: repository, photoDataRepository: dataRepository)
    }

    override func tearDown() {
        apiClient = nil
        repository = nil
        dataRepository = nil
        sut = nil
    }

    func fetchModels() throws -> [PhotoWrapper] {
        let sortDescriptor = SortDescriptor(\PhotoWrapper.photo.id)
        let fetchDescriptor = FetchDescriptor<PhotoWrapper>(sortBy: [sortDescriptor])
        return try dataRepository.modelContext.fetch(fetchDescriptor)
    }

    func test_syncPhotos() async throws {
        // Given
        repository.photos = Photo.mockPhotos
        let expectation = XCTestExpectation(description: "sync photos expectation")
        repository.expectation = expectation

        // When
        await sut.syncPhotos()
        await fulfillment(of: [expectation])

        let models = try fetchModels()

        // Then
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual(sut.isLoading, false)
    }

    func test_syncPhotos_shouldFail() async throws {
        // Given
        repository.shouldFail = true
        let expectation = XCTestExpectation(description: "sync photos expectation")
        repository.expectation = expectation

        // When
        await sut.syncPhotos()
        await fulfillment(of: [expectation])

        // Then
        XCTAssertEqual(sut.alert?.title, "OOPS")
        XCTAssertEqual(sut.alert?.message, "Something went wrong")
        XCTAssertEqual(sut.isLoading, false)
    }

    @MainActor
    func test_syncPhotos_tapped() async throws {
        // Given
        repository.photos = Photo.mockPhotos
        let expectation = XCTestExpectation(description: "sync photos expectation")
        repository.expectation = expectation

        // When
        sut.onAction(.syncTapped)
        await fulfillment(of: [expectation])

        let models = try fetchModels()

        // Then
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual(sut.isLoading, false)
    }
    
    @MainActor
    func test_onPhoto_tapped() async throws {
        // Given
        repository.photos = Photo.mockPhotos
        let expectation = XCTestExpectation(description: "sync photos expectation")
        repository.expectation = expectation

        // When
        sut.syncPhotos()
        await fulfillment(of: [expectation])

        let models = try fetchModels()
        let model = try XCTUnwrap(models.last)
        sut.onAction(.tapPhoto(model))

        // Then
        XCTAssertEqual(sut.selectedPhoto, model)
    }

    @MainActor
    func test_delete_tapped() async throws {
        // Given & When
        sut.onAction(.deleteTapped)

        // Then
        XCTAssertTrue(sut.showConfirmationDialog == true)
    }

    @MainActor
    func test_deleteAll() async throws {
        // Given
        repository.photos = Photo.mockPhotos
        let expectation = XCTestExpectation(description: "sync photos expectation")
        repository.expectation = expectation

        // When
        sut.syncPhotos()
        await fulfillment(of: [expectation])
        sut.onAction(.deleteAll)

        let models = try fetchModels()

        // Then
        XCTAssertEqual(models.count, 0)
        XCTAssertEqual(sut.isLoading, false)
    }
}
