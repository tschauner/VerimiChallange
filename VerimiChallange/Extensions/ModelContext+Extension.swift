//
//  ModelContext+Extension.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 05.05.24.
//

import SwiftData

extension ModelContext {
    func saveChanges() throws {
        if self.hasChanges {
            try self.save()
        }
    }
}

