//
//  ApiRequesting.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

protocol APIRequesting {
    func getFeedData(completion: @escaping (Result<[FeedData], NetworkErrors>) -> Void)
}
