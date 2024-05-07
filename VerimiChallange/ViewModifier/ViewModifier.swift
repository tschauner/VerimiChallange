//
//  ViewModifier.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 06.05.24.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    var role: ButtonRole?
    var action: () -> Void
    func body(content: Content) -> some View {
        Button(role: role) {
            action()
        } label: {
            content
        }
    }
}
