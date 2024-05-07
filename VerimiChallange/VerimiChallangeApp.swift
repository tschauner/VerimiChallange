//
//  VerimiChallangeApp.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 03.05.24.
//

import SwiftUI
import SwiftData

@main
struct VerimiChallangeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var viewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: viewModel,
                photosViewModel: PhotosViewModel(
                    photoDataRepository: appDelegate.repository
                ),
                favoritesViewModel: FavoritesViewModel(
                    photoDataRepository: appDelegate.repository
                )
            )
        }
        .modelContainer(appDelegate.container)
    }
}
