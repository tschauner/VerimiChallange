//
//  Photo+Mock.swift
//  VerimiChallangeTests
//
//  Created by Philipp Tschauner on 05.05.24.
//

@testable import VerimiChallange

extension Photo {
    static let mockPhotos: [Photo] = [
        Photo(
            id: 1,
            title: "Beach Sunrise",
            url: "https://example.com/photo1.jpg",
            thumbnailUrl: "https://example.com/thumb1.jpg"
        ),
        Photo(
            id: 2,
            title: "Mountain Hike",
            url: "https://example.com/photo2.jpg",
            thumbnailUrl: "https://example.com/thumb2.jpg"
        ),
        Photo(
            id: 3,
            title: "City Lights",
            url: "https://example.com/photo3.jpg",
            thumbnailUrl: "https://example.com/thumb3.jpg"
        ),
        Photo(
            id: 4,
            title: "Desert Road",
            url: "https://example.com/photo4.jpg",
            thumbnailUrl: "https://example.com/thumb4.jpg"
        ),
        Photo(
            id: 5,
            title: "Forest Path",
            url: "https://example.com/photo5.jpg",
            thumbnailUrl: "https://example.com/thumb5.jpg"
        )
    ]
}
