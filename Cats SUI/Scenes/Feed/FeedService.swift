//
//  FeedService.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation

protocol FeedServicing {
    var API: APIRequesting { get set }
    func getFeedData(completion: @escaping (Result<[FeedData], NetworkErrors>) -> Void)
}

class FeedService: FeedServicing {
    var API: APIRequesting
        
    init(API: APIRequesting){
        self.API = API
    }
    
    func getFeedData(completion: @escaping (Result<[FeedData], NetworkErrors>) -> Void) {
        self.API.getFeedData() { result in
            completion(result)
        }
    }
}
