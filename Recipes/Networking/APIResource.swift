//
//  APIResource.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

struct APIResource<T> {
    let url: URL
    let method: HTTPMethod
    let body: [String: Any]
    let headers: [String: String]
    let parseData: (Data) -> T?
    
    init(url: URL,
         method: HTTPMethod = .get,
         body: [String: Any] = [:],
         headers: [String: String] = [:],
         parseData: @escaping (Data) -> T?) {
        
        self.url = url
        self.method = method
        self.body = body
        self.headers = headers
        self.parseData = parseData
    }
}

extension APIResource {
    
    static var trendingRecipes: APIResource<RecipeSearchResponse> {
        
        return APIResource<RecipeSearchResponse>(url: URL.trendingRecipes) { data in
            do {
                return try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
            } catch let decodingError {
                print("⚠️ Can not correctly parse RecipeSearchResponse: \(decodingError)")
                return nil
            }
        }
    }
}
