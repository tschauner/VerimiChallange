//
//  View+Extension.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 06.05.24.
//

import SwiftUI

extension View {
    func button(role: ButtonRole? = nil, action: @escaping () -> Void) -> some View {
        modifier(ButtonModifier(role: role, action: action))
    }
}
