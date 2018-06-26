//
//  XCUIElement+Extensions.swift
//  RecipesTests
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import XCTest

extension XCUIElement {
    
    /// Wait for the appearing of an element, with default timeout and `@discardableResult`
    ///
    /// - Parameters:
    ///   - timeout: timeout in seconds, default is 10 seconds
    @discardableResult
    func waitForAppearing(timeout: TimeInterval = 10) -> Bool {
        return waitForExistence(timeout: timeout)
    }
    
    /// Wait for an element to become hittable, with default timeout and `@discardableResult`
    ///
    /// - Parameters:
    ///   - timeout: timeout in seconds, default is 10 seconds
    @discardableResult
    func waitForHittable(timeout: TimeInterval = 10) -> Bool {
        let predicate = NSPredicate(format: "isHittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
    
    /// Delay for certain seconds
    ///
    /// - Parameter seconds: seonds to delay
    @discardableResult
    func delay(_ seconds: Int) -> Bool {
        let delayExpectation = XCTestExpectation(description: "General delay")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {
            delayExpectation.fulfill()
        }
        return XCTWaiter().wait(for: [delayExpectation], timeout: Double(seconds + 1)) == .completed
    }
    
    
    /// Wait for this element to become hittable before tapping on it
    func safeTap() {
        waitForAppearing()
        waitForHittable()
        tap()
    }
    
    /// Wait for textfield becomes hittable, tap to focus keyboard on it, remove current texts, then input text
    func safeType(_ text: String) {
        waitForAppearing()
        waitForHittable()
        tap()
        
        // Add one second delay to make sure keyboard is focused
        delay(1)
        
        // Clear current text if any
        if let currentValue = value as? String, !currentValue.isEmpty {
            let deleteString = currentValue.map { _ in return "\u{8}" }.joined(separator: "")
            typeText(deleteString)
        }

        // Input desired text
        typeText(text)
    }
}
