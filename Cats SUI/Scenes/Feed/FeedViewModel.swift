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
    var isLoadingMore: Bool { get set }
    var errorMessage: String? { get set }
    func run()
    func loadMore()
    func goToDetails(feedData: FeedData) -> AnyView
    func refresh()
    func dismissError()
}

class FeedViewModel: FeedViewmodeling {
    @Published var feedData: [FeedData] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var errorMessage: String?
    
    private var currentPage = 1
    private var canLoadMore = true
    private var service: FeedServicing
    private var coordinator: any FeedCoordinating
    
    init(service: FeedServicing, coordinator: any FeedCoordinating) {
        self.service = service
        self.coordinator = coordinator
        run()
    }
    
    func run() {
        guard !isLoading else { return }
        isLoading = true
        currentPage = 1
        canLoadMore = true
        
        service.getFeedData { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.feedData = response
                    self?.isLoading = false
                    self?.currentPage += 1
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.showError(error)
                }
            }
        }
    }
    
    func loadMore() {
        guard !isLoading && !isLoadingMore && canLoadMore else { return }
        isLoadingMore = true
        
        service.getFeedData { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    if response.isEmpty {
                        self?.canLoadMore = false
                    } else {
                        self?.feedData.append(contentsOf: response)
                        self?.currentPage += 1
                    }
                    self?.isLoadingMore = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoadingMore = false
                    self?.showError(error)
                }
            }
        }
    }
    
    private func showError(_ error: NetworkErrors) {
        switch error {
        case .noConnection:
            errorMessage = "No internet connection. Please check your network and try again."
        case .notFound:
            errorMessage = "Explore data not found. Please try again later."
        default:
            errorMessage = "An unexpected error occurred. Please try again later."
        }
        print("Error fetching exploreData: \(error)")
    }
    
    func dismissError() {
        errorMessage = nil
    }
    
    func goToDetails(feedData: FeedData) -> AnyView {
        return coordinator.goToDetails(feedData: feedData)
    }
    
    func refresh() {
        feedData.removeAll()
        run()
    }
}
