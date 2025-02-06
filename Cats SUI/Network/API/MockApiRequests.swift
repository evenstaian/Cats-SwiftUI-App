//
//  MockApiRequests.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
import UIKit

class MockApiRequests: APIRequesting {
    func getFeedData(completion: @escaping (Result<[FeedData], NetworkErrors>) -> Void) {
        if let filePath = Bundle.main.path(forResource: "mockFeedData", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            generateJSONDataCompletion(jsonData: jsonData, completion: completion)
        } else {
            completion(.failure(.unknown))
        }
    }
    
    private func generateJSONDataCompletion<T: Decodable>(jsonData: Data, completion: @escaping (Result<T, NetworkErrors>) -> Void) {
        do {
            let response = try JSONDecoder().decode(T.self, from: jsonData)
            completion(.success(response))
        } catch let error {
            print(error)
            completion(.failure(.unknown))
        }
    }
}

