//
//  FeedCoordinator.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import Foundation
import SwiftUI

protocol FeedCoordinating: AnyObject {
    func goToDetails(feedData: FeedData) -> AnyView
}

class FeedCoordinator: FeedCoordinating {    
    func goToDetails(feedData: FeedData) -> AnyView {
        let detailsView = DetailsFactory.makeModule(id: feedData.id)
        return AnyView(detailsView)
    }
}
