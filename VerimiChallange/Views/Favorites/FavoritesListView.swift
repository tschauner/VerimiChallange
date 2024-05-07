//
//  FavoritesListView.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import SwiftUI
import SwiftData
import CachedAsyncImage

struct FavoritesListView: View {
    @State var viewModel: FavoritesViewModel
    @Query(filter: #Predicate<PhotoWrapper> { photo in
        photo.isFavorite == true
    }) var favorites: [PhotoWrapper]

    var body: some View {
        NavigationView {
            contentView
                .navigationTitle("Favorites")
                .alert(item: $viewModel.alert) { alert in
                    SwiftUI.Alert(
                        title: Text(alert.title),
                        message: Text(alert.message),
                        dismissButton: .default(Text("OK"))
                    )
                }
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        if favorites.isEmpty {
            emptyView
        } else {
            listView
        }
    }

    var listView: some View {
        List(favorites) { favorite in
            ImageRowView(model: favorite) {
                withAnimation {
                    viewModel.onAction(.toggleFavoriteTapped(favorite))
                }
            }
        }
        .listStyle(.plain)
    }

    var emptyView: some View {
        ContentUnavailableView(label: {
            Text("No Favorites Yet")
        }, description: {
            Text("Press the heart icon to add photos to your favorite list")
        })
    }
}

struct ImageRowView: View {
    let model: PhotoWrapper
    var onFavoriteAction: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            CachedImage(url: model.photo.thumbnailUrl.toURL)
                .frame(width: 40, height: 40)

            Text(model.photo.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
            
            Image(icon: model.isFavorite ? .heartFilled : .heart)
                .foregroundStyle(Color.primary)
                .font(.system(size: 20, weight: .bold))
                .onTapGesture(perform: onFavoriteAction)
        }
    }
}
