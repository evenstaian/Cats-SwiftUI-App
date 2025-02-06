//
//  FeedViewModel.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
import SwiftUI
import Combine

protocol FeedViewmodeling: ObservableObject {
    var feedData: [FeedData] { get set }
    var isLoading: Bool { get set }
    func goToDetails(feedData: FeedData) -> AnyView
    func refresh() async
}

class FeedViewModel: FeedViewmodeling {
    @Published var feedData: [FeedData] = []
    @Published var isLoading: Bool = false
    
    private var service: FeedServicing
    private var coordinator: any FeedCoordinating
    
    init(service: FeedServicing, coordinator: any FeedCoordinating) {
        self.service = service
        self.coordinator = coordinator
        run()
    }
    
    func run(){
        isLoading = true
        service.getFeedData { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.feedData.append(contentsOf: response)
                    self?.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
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
    
    func goToDetails(feedData: FeedData) -> AnyView {
        return coordinator.goToDetails(feedData: feedData)
    }
    
    @MainActor
    func refresh() async {
        isLoading = true
        feedData.removeAll()
        run()
    }
}
