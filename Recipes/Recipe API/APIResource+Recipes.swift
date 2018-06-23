//
//  APIResource+Recipes.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit
import Foundation

extension APIResource {
    
    /// Trending recipes API resource
    static var trendingRecipes: APIResource<RecipeSearchResponse> {
        
        return APIResource<RecipeSearchResponse>(url: URL.trendingRecipes) { data in
            do {
                return try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
            } catch let decodingError {
                print("⚠️ Decoding error in \(#function): \(decodingError)")
                return nil
            }
        }
    }
    
    /// Search recipes API resource
    static func searchRecipes(with query: String) -> APIResource<RecipeSearchResponse> {
        
        return APIResource<RecipeSearchResponse>(url: URL.searchRecipes(with: query)) { data in
            do {
                return try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
            } catch let decodingError {
                print("⚠️ Decoding error in \(#function): \(decodingError)")
                return nil
            }
        }
    }
    
    /// Get recipe details API resource
    static func recipeDetail(with recipeId: String) -> APIResource<RecipeDetailResponse> {
        
        return APIResource<RecipeDetailResponse>(url: URL.getRecipeDetail(with: recipeId)) { data in
            do {
                return try JSONDecoder().decode(RecipeDetailResponse.self, from: data)
            } catch let decodingError {
                print("⚠️ Decoding error in \(#function): \(decodingError)")
                return nil
            }
        }
    }
    
    /// Load recipe image API resource
    static func recipeImage(with url: URL) -> APIResource<UIImage> {
        
        return APIResource<UIImage>(url: url) { data in
            
            guard let image = UIImage(data: data) else {
                return nil
            }
            
            return image
        }
    }
}
