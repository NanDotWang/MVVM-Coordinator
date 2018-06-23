//
//  APIServiceTests.swift
//  RecipesTests
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import XCTest
@testable import Recipes

class APIServiceTests: XCTestCase {
    
    func testSuccessfulResponse() {
        // Setup mock objects
        let session = URLSessionMock()
        let apiService = APIService(urlSession: session)
        
        // Create data and tell the session to always return it
        let data = "string".data(using: .utf8)
        session.data = data
        
        // Create a URL (using the file path API to avoid optionals)
        let url = URL(fileURLWithPath: "url")
        
        // Create mock api resource
        let mockResource = APIResource(url: url, parseData: DummyModel.init)
        
        // Perform the request and verify the result
        apiService.load(mockResource) { (result) in
            switch result {
            case .success(let dummyModel):
                XCTAssertEqual(data, dummyModel.data)
            case .failure(_): break
            }
        }
    }
    
    func testFailureResponse() {
        // Setup our objects
        let session = URLSessionMock()
        let apiService = APIService(urlSession: session)
        
        // Create data and tell the session to always return it
        let error = NSError(domain: "com.nan.recipeTests", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        session.error = error
        
        // Create a URL (using the file path API to avoid optionals)
        let url = URL(fileURLWithPath: "url")
        
        // Create mock api resource
        let mockResource = APIResource(url: url, parseData: DummyModel.init)
        
        // Perform the request and verify the result
        apiService.load(mockResource) { (result) in
            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error, NetworkingError.noInternet)
            }
        }
    }
}
