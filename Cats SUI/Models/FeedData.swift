//
//  FeedData.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

struct FeedData: Codable, Identifiable {
    let id: String
    let width: Int?
    let height: Int?
    let url: String
    let breeds: [Breed]?
}

