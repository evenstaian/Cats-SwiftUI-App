import XCTest
import SwiftUI
@testable import Cats_SUI

final class FeedViewModelTests: XCTestCase {
    var sut: FeedViewModel!
    var mockService: MockFeedService!
    var mockCoordinator: MockFeedCoordinator!
    
    override func setUp() {
        super.setUp()
        mockService = MockFeedService()
        mockCoordinator = MockFeedCoordinator()
        sut = FeedViewModel(service: mockService, coordinator: mockCoordinator)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    func test_init_shouldLoadInitialData() {
        // Then
        let exp = expectation(description: "Wait for async")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            XCTAssertFalse(self.sut.feedData.isEmpty)
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertNil(self.sut.errorMessage)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_run_shouldLoadData() {
        // When
        sut.run()
        
        // Then
        let exp = expectation(description: "Wait for async")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            XCTAssertFalse(self.sut.feedData.isEmpty)
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertNil(self.sut.errorMessage)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_loadMore_shouldAppendMoreData() {
        // Given
        let exp1 = expectation(description: "Wait for initial load")
        let exp2 = expectation(description: "Wait for load more")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            let initialCount = self.sut.feedData.count
            
            // When
            self.sut.loadMore()
            
            // Then
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                XCTAssertGreaterThan(self.sut.feedData.count, initialCount)
                XCTAssertFalse(self.sut.isLoadingMore)
                XCTAssertNil(self.sut.errorMessage)
                exp2.fulfill()
            }
            exp1.fulfill()
        }
        
        wait(for: [exp1, exp2], timeout: 2.0)
    }
    
    func test_refresh_shouldReloadData() {
        // Given
        let exp1 = expectation(description: "Wait for initial load")
        let exp2 = expectation(description: "Wait for refresh")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            let initialData = self.sut.feedData
            
            // When
            self.sut.refresh()
            
            // Then
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                XCTAssertFalse(self.sut.feedData.isEmpty)
                XCTAssertEqual(self.sut.feedData, initialData)
                XCTAssertFalse(self.sut.isLoading)
                exp2.fulfill()
            }
            exp1.fulfill()
        }
        
        wait(for: [exp1, exp2], timeout: 2.0)
    }
    
    func test_goToDetails_shouldCallCoordinator() {
        // Given
        let exp = expectation(description: "Wait for data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            guard let feedData = self.sut.feedData.first else {
                XCTFail("Should have feed data")
                return
            }
            
            // When
            _ = self.sut.goToDetails(feedData: feedData)
            
            // Then
            XCTAssertEqual(self.mockCoordinator.goToDetailsCallCount, 1)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_dismissError_shouldClearErrorMessage() {
        // Given
        sut.errorMessage = "Test error"
        
        // When
        sut.dismissError()
        
        // Then
        XCTAssertNil(sut.errorMessage)
    }
} 
