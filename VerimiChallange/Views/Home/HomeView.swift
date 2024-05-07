//
//  HomeView.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var viewModel: HomeViewModel
    @State var photosViewModel: PhotosViewModel
    @State var favoritesViewModel: FavoritesViewModel

    var body: some View {
        TabView(selection: $viewModel.currentTab) {
            ForEach(HomeViewModel.Tabs.allCases, id: \.self) { tab in
                tabView(tab)
                    .environment(viewModel)
                    .tag(tab)
                    .tabItem {
                        Label {
                            Text(tab.rawValue.capitalized)
                        } icon: {
                            Image(icon: tab.icon)
                        }
                    }
            }
        }
    }

    @ViewBuilder
    func tabView(_ tab: HomeViewModel.Tabs) -> some View  {
        switch tab {
        case .photos:
            PhotosView(viewModel: photosViewModel)
        case .favorites:
            FavoritesListView(viewModel: favoritesViewModel)
        }
    }
}
