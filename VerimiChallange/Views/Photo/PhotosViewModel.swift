//
//  PhotosViewModel.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import SwiftUI
import SwiftData

@Observable
final class PhotosViewModel: Coordinator {
    private let photoRepository: PhotoRepositoryProtocol
    private let photoDataRepository: PhotoDataRepositoryProtocol
    private let maxPhotos = 5000
    private let pageSize = 60

    @ObservationIgnored @AppStorage("currentPage") var currentPage: Int = 1
    var isLoading = false
    var selectedPhoto: PhotoWrapper?
    var alert: Alert?
    var showConfirmationDialog = false
    var currentColumns: Column = .three

    var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: currentColumns.rawValue)
    }

    init(photoRepository: PhotoRepositoryProtocol = PhotoRepository(),
         photoDataRepository: PhotoDataRepositoryProtocol
    ) {
        self.photoRepository = photoRepository
        self.photoDataRepository = photoDataRepository
    }

    private func deleteAll() {
        do {
            try photoDataRepository.deleteAll()
            currentPage = 1
        } catch {
            self.alert = .general
        }
    }

    private func trashIconTapped() {
        showConfirmationDialog = true
    }

    private func onTapPhoto(_ photo: PhotoWrapper) {
        selectedPhoto = photo
    }

    private func toggleFavorites(_ photo: PhotoWrapper) {
        do {
            try photoDataRepository.updateFavorite(photo)
        } catch {
            self.alert = .general
        }
    }

    func getPhotos() async throws -> [Photo] {
        try await photoRepository.getPhotos(page: currentPage, limit: pageSize)
    }

    func shouldLoadNextPage(models: [PhotoWrapper], model: PhotoWrapper) -> Bool {
        if let lastModel = models.last, lastModel == model {
            return true
        } else {
            return false
        }
    }

    @MainActor
    func loadNewPage()  {
        Task {
            let maxPages = maxPhotos/pageSize
            guard currentPage <= maxPages else {
                return
            }
            print("currentPage: \(currentPage)")
            currentPage += 1
            syncPhotos()
        }
    }

    @MainActor
    func syncPhotos() {
        Task {
            do {
                isLoading = true
                let photos = try await getPhotos()
                let wrapper = photos.map { PhotoWrapper(photo: $0) }
                try photoDataRepository.saveModels(models: wrapper)
                isLoading = false
            } catch {
                self.alert = .general
                isLoading = false
            }
        }
    }

    func onAction(_ action: Action) {
        switch action {
        case .tapPhoto(let model):
            onTapPhoto(model)
        case .toggleFavoriteTapped(let model):
            toggleFavorites(model)
        case .deleteTapped:
            trashIconTapped()
        case .deleteAll:
            deleteAll()
        case .syncTapped:
            Task { await syncPhotos() }
        }
    }
}

extension PhotosViewModel {
    enum Action {
        case tapPhoto(PhotoWrapper)
        case toggleFavoriteTapped(PhotoWrapper)
        case syncTapped
        case deleteTapped
        case deleteAll
    }

    enum Column: Int, CaseIterable {
        case two = 2
        case three
        case four
    }
}
