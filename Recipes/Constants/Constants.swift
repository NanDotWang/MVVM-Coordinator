//
//  Constants.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-22.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

/// App related constants
struct Constants {
    
    /// Backend related constants
    struct Backend {
        
        static let scheme = "http"
        static let host = "food2fork.com"
        static let key = "b549c4c96152e677eb90de4604ca61a2"
        
        static let searchRecipePath = "/api/search"
        static let getRecipePath = "/api/get"
        
        static let sortByTrending = "t"
        static let sortByRating = "r"
    }
}
