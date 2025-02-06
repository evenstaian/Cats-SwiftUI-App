//
//  FeedData.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

struct FeedData: Codable, Identifiable, Hashable {
    let id: String
    let width: Int?
    let height: Int?
    let url: String
    let breeds: [Breed]?
    
    // Implementação do Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FeedData, rhs: FeedData) -> Bool {
        lhs.id == rhs.id
    }
}

