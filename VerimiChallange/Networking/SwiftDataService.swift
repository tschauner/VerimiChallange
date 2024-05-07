//
//  SwiftDataService.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 05.05.24.
//

import Foundation
import SwiftData

protocol DataServiceProtocol {
    var modelContext: ModelContext { get set }
}

extension DataServiceProtocol {
    func fetch<T>(_ descriptor: FetchDescriptor<T>) throws -> [T] where T : PersistentModel {
        try modelContext.fetch(descriptor)
    }

    func insert<T>(_ model: T) where T : PersistentModel {
        modelContext.insert(model)
    }

    func delete<T>(_ model: T) where T : PersistentModel {
        modelContext.delete(model)
    }

    func delete<T>(
        model: T.Type,
        where predicate: Predicate<T>? = nil,
        includeSubclasses: Bool = true
    ) throws where T : PersistentModel {
        try modelContext.delete(model: T.self)
    }

    func saveChanges() throws {
        try modelContext.saveChanges()
    }

    var container: ModelContainer {
        modelContext.container
    }
}
