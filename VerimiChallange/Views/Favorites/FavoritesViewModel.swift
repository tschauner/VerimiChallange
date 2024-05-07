//
//  FavoritesViewModel.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 06.05.24.
//

import Foundation

@Observable
final class FavoritesViewModel: Coordinator {
    private let photoDataRepository: PhotoDataRepositoryProtocol
    var alert: Alert?

    init(photoDataRepository: PhotoDataRepositoryProtocol) {
        self.photoDataRepository = photoDataRepository
    }

    private func toggleFavorite(_ photo: PhotoWrapper) {
        do {
            try photoDataRepository.updateFavorite(photo)
        } catch {
            self.alert = .general
        }
    }

    func onAction(_ action: Action) {
        switch action {
        case let .toggleFavoriteTapped(model):
            toggleFavorite(model)
        }
    }
}

extension FavoritesViewModel {
    enum Action {
        case toggleFavoriteTapped(PhotoWrapper)
    }
}
