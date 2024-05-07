//
//  MockPhotoDataRepository.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

import XCTest
import SwiftData
@testable import VerimiChallange

final class MockPhotoDataRepository: PhotoDataRepositoryProtocol {
    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}
