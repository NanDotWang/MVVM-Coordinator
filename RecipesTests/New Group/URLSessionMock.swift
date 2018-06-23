//
//  URLSessionMock.swift
//  RecipesTests
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

/// Mock `URLSession`
class URLSessionMock: URLSession {
    var data: Data?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSessionDataTaskMock { [weak self] in
            completionHandler(self?.data, nil, self?.error)
        }
    }
}
