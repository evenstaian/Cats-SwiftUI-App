//
//  MockDetailsService.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
@testable import Cats_SUI

class MockDetailsService: DetailsServicing {
    var API: APIRequesting
    
    init(mockAPI: APIRequesting = MockApiRequests()) {
        self.API = mockAPI
    }
    
    func getDetailsData(id: String, completion: @escaping (Result<FeedData, NetworkErrors>) -> Void) {
        API.getDetailsData(id: id, completion: completion)
    }
} 