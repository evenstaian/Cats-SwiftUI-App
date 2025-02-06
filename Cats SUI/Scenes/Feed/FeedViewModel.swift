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
    
    var service: Any?
    
    init(){
        run()
    }
    
    func run(){
        // TODO
    }
    
    func goToDetails(feedData: FeedData) {
        // TODO
    }
}
