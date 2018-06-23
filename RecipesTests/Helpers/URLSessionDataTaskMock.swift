//
//  URLSessionDataTaskMock.swift
//  RecipesTests
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

/// Mock `URLSessionDataTask`
class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // Simply call the closure right away when `resume`
    override func resume() {
        closure()
    }
}
