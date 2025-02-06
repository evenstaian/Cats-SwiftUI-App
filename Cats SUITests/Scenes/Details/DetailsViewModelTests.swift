//
//  DetailsViewModelTests.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import XCTest
@testable import Cats_SUI

final class DetailsViewModelTests: XCTestCase {
    var sut: DetailsViewModel!
    var mockService: MockDetailsService!
    let testId = "test_id"
    
    override func setUp() {
        super.setUp()
        mockService = MockDetailsService()
        sut = DetailsViewModel(id: testId, service: mockService)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func test_init_shouldLoadDetailsData() {
        // Then
        let exp = expectation(description: "Wait for async")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            XCTAssertNotNil(self.sut.detailsData)
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
            XCTAssertNotNil(self.sut.detailsData)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_refresh_shouldReloadData() {
        // Given
        let exp1 = expectation(description: "Wait for initial load")
        let exp2 = expectation(description: "Wait for refresh")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            let initialData = self.sut.detailsData
            
            // When
            Task {
                await self.sut.refresh()
                
                // Then
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                    XCTAssertNotNil(self.sut.detailsData)
                    XCTAssertEqual(self.sut.detailsData, initialData)
                    exp2.fulfill()
                }
            }
            exp1.fulfill()
        }
        
        wait(for: [exp1, exp2], timeout: 2.0)
    }
    
    func test_showError_shouldHandleNoConnection() {
        // Given
        let customMockService = MockDetailsService(mockAPI: MockAPIWithError(error: .noConnection))
        sut = DetailsViewModel(id: testId, service: customMockService)
        
        // When
        sut.run()
        
        // Then
        let exp = expectation(description: "Wait for error")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            XCTAssertNil(self.sut.detailsData)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
}

class MockAPIWithError: APIRequesting {
    let error: NetworkErrors
    
    init(error: NetworkErrors) {
        self.error = error
    }
    
    func getFeedData(completion: @escaping (Result<[FeedData], NetworkErrors>) -> Void) {
        completion(.failure(error))
    }
    
    func getDetailsData(id: String, completion: @escaping (Result<FeedData, NetworkErrors>) -> Void) {
        completion(.failure(error))
    }
}

