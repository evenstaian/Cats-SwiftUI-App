//
//  DetailsService.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation

protocol DetailsServicing {
    var API: APIRequesting { get set }
    func getDetailsData(id: String, completion: @escaping (Result<FeedData, NetworkErrors>) -> Void)
}

class DetailsService: DetailsServicing {
    var API: APIRequesting
        
    init(API: APIRequesting){
        self.API = API
    }
    
    func getDetailsData(id: String, completion: @escaping (Result<FeedData, NetworkErrors>) -> Void) {
        self.API.getDetailsData(id: id) { result in
            completion(result)
        }
    }
}
