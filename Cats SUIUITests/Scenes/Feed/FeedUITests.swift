//
//  FeedUITests.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import XCTest

final class FeedUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func test_initialLoad_shouldShowFeedItems() {
        // Then
        let feedList = app.scrollViews.firstMatch
        XCTAssertTrue(feedList.exists)
        
        let firstItem = feedList.otherElements.firstMatch
        XCTAssertTrue(firstItem.waitForExistence(timeout: 5))
    }
    
    func test_pullToRefresh_shouldReloadData() {
        // Given
        let feedList = app.scrollViews.firstMatch
        let start = feedList.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let end = feedList.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
        
        // When
        start.press(forDuration: 0.1, thenDragTo: end)
        
        // Then
        let pawPrint = app.otherElements["PawPrintView"]
        XCTAssertTrue(pawPrint.waitForExistence(timeout: 2))
    }
    
    func test_tapDetails_shouldNavigateToDetailsScreen() {
        // Given
        let feedList = app.scrollViews.firstMatch
        XCTAssertTrue(feedList.waitForExistence(timeout: 5))
        
        // When
        let firstSeeDetailsButton = app.buttons["See details"].firstMatch
        XCTAssertTrue(firstSeeDetailsButton.waitForExistence(timeout: 2))
        firstSeeDetailsButton.tap()
        
        // Then
        let detailsView = app.otherElements["DetailsView"]
        XCTAssertTrue(detailsView.waitForExistence(timeout: 2))
    }
    
    func test_scrollToBottom_shouldLoadMoreData() {
        // Given
        let feedList = app.scrollViews.firstMatch
        XCTAssertTrue(feedList.waitForExistence(timeout: 5))
        
        // When
        feedList.swipeUp(velocity: .fast)
        feedList.swipeUp(velocity: .fast)
        
        // Then
        let loadingMore = app.staticTexts["Fetching more data..."]
        XCTAssertTrue(loadingMore.waitForExistence(timeout: 2))
    }
    
    
    func test_errorState_shouldShowErrorView() {
        
        // Given
        app.launchArguments = ["UI_TEST_ERROR"]
        app.launch()
        
        // Then
        let errorView = app.otherElements["ErrorView"]
        XCTAssertTrue(errorView.waitForExistence(timeout: 2))
        
        // When
        let dismissButton = errorView.buttons["Dismiss"]
        dismissButton.tap()
        
        // Then
        XCTAssertFalse(errorView.exists)
    }
}

