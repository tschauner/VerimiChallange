//
//  Photo.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//

import Foundation

struct Photo: Codable, Equatable {
    let id: Int
    let title, url, thumbnailUrl: String
}
