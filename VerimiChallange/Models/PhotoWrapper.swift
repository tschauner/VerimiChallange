//
//  PhotoWrapper.swift
//  VerimiChallange
//
//  Created by Philipp Tschauner on 04.05.24.
//
import Foundation
import SwiftData

@Model
class PhotoWrapper: Identifiable, Equatable {
    @Attribute(.unique)
    let id: Int
    var photo: Photo
    var isFavorite: Bool = false
    
    init(photo: Photo, isFavorite: Bool = false) {
        self.id = photo.id
        self.photo = photo
        self.isFavorite = isFavorite
    }
}
