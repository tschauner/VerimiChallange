//
//  Coordinator.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 06.05.24.
//

import Foundation

protocol Coordinator {
    associatedtype Action
    func onAction(_ action: Action)
}
