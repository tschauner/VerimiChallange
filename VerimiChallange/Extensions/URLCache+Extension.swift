//
//  URLCache+Extension.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
