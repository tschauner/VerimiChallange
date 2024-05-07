//
//  Alert.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 05.05.24.
//

import Foundation

struct Alert: Identifiable, Equatable {
    var id: String { message }
    let title: String
    let message: String
}

extension Alert {
    static var general: Self {
        Alert(title: "OOPS", message: "Something went wrong")
    }
}
