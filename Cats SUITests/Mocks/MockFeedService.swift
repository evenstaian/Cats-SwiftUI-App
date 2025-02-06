import Foundation
import SwiftUI
@testable import Cats_SUI

class MockFeedService: FeedServicing {
    var API: APIRequesting
    
    init(mockAPI: APIRequesting = MockApiRequests()) {
        self.API = mockAPI
    }
    
    func getFeedData(completion: @escaping (Result<[FeedData], NetworkErrors>) -> Void) {
        API.getFeedData(completion: completion)
    }
}

class MockFeedCoordinator: FeedCoordinating {
    var goToDetailsCallCount = 0
    
    func goToDetails(feedData: FeedData) -> AnyView {
        goToDetailsCallCount += 1
        return AnyView(EmptyView())
    }
} 