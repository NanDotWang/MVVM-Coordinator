//
//  RequestToken.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

/// A request token that is used to cancel ongoing task
class RequestToken {
    private weak var task: URLSessionDataTask?
    
    init(task: URLSessionDataTask) {
        self.task = task
    }
    
    func cancel() {
        task?.cancel()
    }
}
