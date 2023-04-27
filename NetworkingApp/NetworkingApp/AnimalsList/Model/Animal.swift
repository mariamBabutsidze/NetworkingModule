//
//  Animal.swift
//  NetworkingApp
//
//  Created by Mariam Babutsidze on 26.04.23.
//

import Foundation

struct Animal: Codable {
    var id: Int?
    let organizationId: String?
    let url: URL?
    let type: String
    let species: String?
    let publishedAt: String?
    let distance: Double?
    var ranking: Int? = 0
    let photos: [PhotoSizes]
    let name: String
    let description: String
    
    var picture: URL? {
        photos.first?.medium ?? photos.first?.large
    }
}

extension Animal: Identifiable {
    
}

struct AnimalsContainer: Codable {
    let animals: [Animal]
}

struct PhotoSizes: Codable {
    var id: Int?
    var small: URL?
    var medium: URL?
    var large: URL?
    var full: URL?
}
