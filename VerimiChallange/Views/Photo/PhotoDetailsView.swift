//
//  PhotoDetailsView.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 05.05.24.
//

import SwiftUI

struct PhotoDetailView: View {
    @Environment(PhotosViewModel.self) var viewModel
    let model: PhotoWrapper

    var body: some View {
        VStack(spacing: 20) {
            PhotoImage(url: model.photo.url.toURL,
                       index: model.photo.id,
                       isFavorite: model.isFavorite
            ) {
                viewModel.onAction(.toggleFavoriteTapped(model))
            }
            .onTapGesture(count: 2) {
                viewModel.onAction(.toggleFavoriteTapped(model))
            }

            Text(model.photo.title)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            Spacer()
        }
    }
}
