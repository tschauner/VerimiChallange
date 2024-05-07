//
//  PhotoImage.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import SwiftUI
import CachedAsyncImage

struct PhotoImage: View {
    let url: URL?
    let index: Int
    let isFavorite: Bool
    var onTapFavorite: () -> Void

    var body: some View {
        CachedImage(url: url)
            .overlay(alignment: .bottomTrailing) {
                Image(icon: isFavorite ? .heartFilled : .heart)
                    .foregroundStyle(Color.primary)
                    .font(.system(size: 20, weight: .bold))
                    .padding(10)
                    .button(action: onTapFavorite)
            }
            .overlay(alignment: .topLeading) {
                Text("\(index)")
                    .padding(10)
            }
    }
}

struct CachedImage: View {
    let url: URL?

    var body: some View {
        GeometryReader { reader in
            CachedAsyncImage(url: url, urlCache: .imageCache) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.black
                    .overlay(
                        ProgressView()
                    )
            }
            .frame(width: reader.size.height,
                   height: reader.size.width
            )
        }
        .clipped()
        .aspectRatio(1, contentMode: .fit)
    }
}
