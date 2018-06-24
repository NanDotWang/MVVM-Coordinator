//
//  RecipesUITests.swift
//  RecipesTests
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import XCTest

class RecipesUITests: XCTestCase {
    
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app.terminate()
    }
    
    func testShowInstructionsWebPage() {
        app.cells.firstMatch.safeTap()
        app.buttons["showInstructionsButton"].safeTap()
        app.delay(1)
        
        XCTAssertTrue(app.buttons["Open in Safari"].exists)
    }
    
    func testShowOriginalWebPage() {
        app.cells.firstMatch.safeTap()
        app.buttons["showOriginalButton"].safeTap()
        app.delay(1)
        
        XCTAssertTrue(app.buttons["Open in Safari"].exists)
    }
    
    func testSearchWithResults() {
        app.searchFields.firstMatch.safeType("Chicken")
        app.cells.firstMatch.safeTap()
        app.buttons["showInstructionsButton"].safeTap()
        app.delay(1)
        
        XCTAssertTrue(app.buttons["Done"].exists)
    }
    
    func testSearchNoResults() {
        app.searchFields.firstMatch.safeType("asdfasdfasdfasdf")
        app.delay(3)
        
        XCTAssertFalse(app.cells.firstMatch.exists)
    }
}
