//
//  FeedViewModel.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
import Combine

protocol FeedViewmodeling: ObservableObject {
    var feedData : [FeedData] { get set}
    func goToDetails(feedData: FeedData)
}

class FeedViewModel: FeedViewmodeling {
    
    @Published var feedData: [FeedData] = []
    
    var service: FeedServicing
    
    init(service: FeedServicing){
        self.service = service
        run()
    }
    
    func run(){
        service.getFeedData { [weak self] result in
            switch result {
            case .success(let response):
                self?.feedData.append(contentsOf: response)
            case .failure(let error):
                switch error {
                case .noConnection:
                    self?.showError("No internet connection. Please check your network and try again.")
                case .notFound:
                    self?.showError("Explore data not found. Please try again later.")
                default:
                    self?.showError("An unexpected error occurred. Please try again later.")
                }
                print("Error fetching exploreData: \(error)")
            }
        }
    }
    
    private func showError(_ message: String) {
        // TODO
    }
    
    func goToDetails(feedData: FeedData) {
        // TODO
    }
}
