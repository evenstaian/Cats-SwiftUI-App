//
//  DetailsViewModel.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
import Combine

protocol DetailsViewmodeling: ObservableObject {
    var detailsData : FeedData? { get set}
    func refresh() async
}

class DetailsViewModel: DetailsViewmodeling {
    var id: String
    @Published var detailsData : FeedData?
    
    var service: DetailsServicing
    
    init(id: String, service: DetailsServicing){
        self.id = id
        self.service = service
        run()
    }
    
    func run(){
        service.getDetailsData(id: self.id) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.detailsData = response
                }
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
    func refresh() async {
        
    }
}
