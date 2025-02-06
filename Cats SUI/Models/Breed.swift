//
//  Breeds.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

struct Breed: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let countryCode: String
    let lifeSpan: String
    let wikipediaUrl: String
    let weight: Weight
    
    enum CodingKeys: String, CodingKey {
        case id, name, temperament, origin
        case countryCode = "country_code"
        case lifeSpan = "life_span"
        case wikipediaUrl = "wikipedia_url"
        case weight
    }
}

struct Weight: Codable, Hashable {
    let imperial: String
    let metric: String
}

