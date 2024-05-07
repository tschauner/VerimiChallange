//
//  HomeViewModel.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

@Observable
final class HomeViewModel {
    var currentTab: Tabs = .photos
}

extension HomeViewModel {
    enum Tabs: String, CaseIterable {
        case photos
        case favorites

        var icon: VerimiIcon {
            switch self {
            case .photos:
                return .photo
            case .favorites:
                return .heart
            }
        }
    }
}
