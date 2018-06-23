//
//  URL+Recipes.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-22.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

extension URL {
    
    static var trendingRecipes: URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = Constants.Backend.scheme
        urlComponent.host = Constants.Backend.host
        urlComponent.path = Constants.Backend.searchRecipePath
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: Constants.Backend.key),
            URLQueryItem(name: "sort", value: Constants.Backend.sortByTrending),
            URLQueryItem(name: "count", value: "10")
        ]
        
        guard let url = urlComponent.url else { preconditionFailure("⚠️ Cannot construct \(#function) url") }
        
        return url
    }
    
    static func searchRecipes(with query: String) -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = Constants.Backend.scheme
        urlComponent.host = Constants.Backend.host
        urlComponent.path = Constants.Backend.searchRecipePath
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: Constants.Backend.key),
            URLQueryItem(name: "sort", value: Constants.Backend.sortByRating),
            URLQueryItem(name: "q", value: query)
        ]
        
        guard let url = urlComponent.url else { preconditionFailure("⚠️ Cannot construct \(#function) url") }
        
        return url
    }
    
    static func getRecipeDetail(with recipeId: String) -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = Constants.Backend.scheme
        urlComponent.host = Constants.Backend.host
        urlComponent.path = Constants.Backend.getRecipePath
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: Constants.Backend.key),
            URLQueryItem(name: "rId", value: recipeId)
        ]
        
        guard let url = urlComponent.url else { preconditionFailure("⚠️ Cannot construct \(#function) url") }
        
        return url
    }
}
