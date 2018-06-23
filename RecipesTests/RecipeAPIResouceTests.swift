//
//  RecipeAPIResouceTests.swift
//  RecipesTests
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import XCTest
@testable import Recipes

class RecipeAPIResouceTests: XCTestCase {
    
    func testTrendingRecipesResource() {
        let resource = APIResource<RecipeSearchResponse>.trendingRecipes
        
        XCTAssertEqual(resource.url, URL.trendingRecipes)
        XCTAssertEqual(resource.method, .get)
        XCTAssertEqual(resource.body.isEmpty, true)
        XCTAssertEqual(resource.headers.isEmpty, true)
    }
    
    func testSearchRecipesResource() {
        let searchKeyword = "search_keyword"
        let resource = APIResource<RecipeSearchResponse>.searchRecipes(with: searchKeyword)
        
        XCTAssertEqual(resource.url, URL.searchRecipes(with: searchKeyword))
        XCTAssertEqual(resource.method, .get)
        XCTAssertEqual(resource.body.isEmpty, true)
        XCTAssertEqual(resource.headers.isEmpty, true)
    }
    
    func testRecipeDetailResource() {
        let recipeId = "recipe_id"
        let resource = APIResource<RecipeDetailResponse>.recipeDetail(with: recipeId)
        
        XCTAssertEqual(resource.url, URL.getRecipeDetail(with: recipeId))
        XCTAssertEqual(resource.method, .get)
        XCTAssertEqual(resource.body.isEmpty, true)
        XCTAssertEqual(resource.headers.isEmpty, true)
    }
}
