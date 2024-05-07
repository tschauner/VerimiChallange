//
//  ContentView.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 03.05.24.
//

import SwiftUI
import CachedAsyncImage
import SwiftData

struct PhotosView: View {
    @State var viewModel: PhotosViewModel
    @Query(sort: \PhotoWrapper.id, order: .forward) var photos: [PhotoWrapper]

    var body: some View {
        NavigationView {
            contentView
                .overlay(
                    ZStack {
                        if viewModel.isLoading {
                            ProgressView()
                        }
                    }
                )
                .task {
                    viewModel.syncPhotos()
                }
                .sheet(item: $viewModel.selectedPhoto) { model in
                    PhotoDetailView(model: model)
                        .environment(viewModel)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.height(600)])
                }
                .alert(item: $viewModel.alert) { alert in
                    SwiftUI.Alert(
                        title: Text(alert.title),
                        message: Text(alert.message),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .confirmationDialog("Do you really want to delete all photos?",
                                    isPresented: $viewModel.showConfirmationDialog,
                                    titleVisibility: .visible
                ) {

                    Text("Delete all")
                        .button(role: .destructive) {
                            viewModel.onAction(.deleteAll)
                        }
                }
                .toolbar {
                    if !photos.isEmpty {
                        ToolbarItem(placement: .topBarTrailing) {
                            Image(icon: .trash)
                                .button {
                                    viewModel.onAction(.deleteTapped)
                                }
                        }
                    }

                    ToolbarItem(placement: .topBarLeading) {
                        pickerView
                    }
                }
                .navigationTitle("Photos")
        }
    }

    @ViewBuilder
    var contentView: some View {
        if photos.isEmpty && !viewModel.isLoading {
            emptyView
        } else {
            photoGridView
        }
    }

    @ViewBuilder
    var pickerView: some View {
        Menu {
            Picker("", selection: $viewModel.currentColumns.animation()) {
                ForEach(PhotosViewModel.Column.allCases, id: \.self) { column in
                    Text("Columns: \(column.rawValue)")
                }
            }

        } label: {
            Image(icon: .grid)
        }
    }

    var emptyView: some View {
        ContentUnavailableView {
            Text("No Photos Available Yet")
        } actions: {
            Text("Get photos")
                .frame(height: 45)
                .foregroundStyle(Color.primary)
                .padding(.horizontal, 15)
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.top, 15)
                .button {
                    viewModel.onAction(.syncTapped)
                }
        }
    }

    var photoGridView: some View {
        ScrollView {
            LazyVGrid(columns: viewModel.columns) {
                ForEach(photos) { model in
                    PhotoImage(url: model.photo.thumbnailUrl.toURL,
                               index: model.photo.id,
                               isFavorite: model.isFavorite
                    ) {
                        viewModel.onAction(.toggleFavoriteTapped(model))
                    }
                    .environment(viewModel)
                    .onTapGesture(count: 2) {
                        viewModel.onAction(.toggleFavoriteTapped(model))
                    }
                    .onTapGesture {
                        withAnimation {
                            viewModel.onAction(.tapPhoto(model))
                        }
                    }
                    .task {
                        if viewModel.shouldLoadNextPage(models: photos, model: model) {
                            await viewModel.loadNewPage()
                        }
                    }
                }
            }
        }
    }
}
