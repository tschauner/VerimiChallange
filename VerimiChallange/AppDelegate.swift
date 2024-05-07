//
//  AppDelegate.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 06.05.24.
//

import UIKit
import SwiftData

final class AppDelegate: NSObject, UIApplicationDelegate {
    var container: ModelContainer!
    var repository: PhotoDataRepositoryProtocol!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        do {
            self.container = try ModelContainer(for: PhotoWrapper.self)
            self.repository = PhotoDataRepository(modelContext: container.mainContext)
        } catch {
            fatalError(
                "Failed to create ModelContainer for PhotoWrapper."
            )
        }
        return true
    }
}
