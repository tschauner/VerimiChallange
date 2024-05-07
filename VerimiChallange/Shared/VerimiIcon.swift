//
//  VerimiIcon.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import SwiftUI

enum VerimiIcon: String {
    case heart
    case heartFilled = "heart.fill"
    case photos = "photo.on.rectangle"
    case photo
    case trash
    case grid = "circle.grid.2x2"
}

extension Image {

    init(icon: VerimiIcon) {
        self.init(systemName: icon.rawValue)
    }
}
