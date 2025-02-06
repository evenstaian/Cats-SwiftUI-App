//
//  DetailsUITests.swift
//  Cats SUI
//
//  Created by Evens Taian on 06/02/25.
//

import XCTest

final class DetailsUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
        navigateToDetails()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    private func navigateToDetails() {
        sleep(2)
        
        app.buttons["See details"].firstMatch.tap()
    }
    
    func test_detailsView_shouldShowMainElements() {
        sleep(2)
        
        XCTAssertTrue(app.staticTexts["Abyssinian"].exists)
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH %@", "Origin:")).element.exists)
    }
    
    func test_detailsView_shouldShowWeightSection() {
        sleep(2)
        
        XCTAssertTrue(app.staticTexts["Weight Information"].exists)
        XCTAssertTrue(app.staticTexts["Imperial"].exists)
        XCTAssertTrue(app.staticTexts["Metric"].exists)
    }
    
    func test_detailsView_shouldShowCharacteristicsSection() {
        sleep(2)
        
        XCTAssertTrue(app.staticTexts["Characteristics"].exists)
        XCTAssertTrue(app.staticTexts["Temperament"].exists)
        XCTAssertTrue(app.staticTexts["Life Span"].exists)
        XCTAssertTrue(app.staticTexts["Country"].exists)
    }
    
    func test_wikipediaLink_shouldExist() {
        sleep(2)
        
        XCTAssertTrue(app.staticTexts["Read More on Wikipedia"].exists)
    }
    
    func test_scrolling_shouldShowAllContent() {
        sleep(2)
        
        app.swipeUp()
        
        XCTAssertTrue(app.staticTexts["Technical Details"].exists)
    }
}

