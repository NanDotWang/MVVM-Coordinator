//
//  RecipeUrlTests.swift
//  RecipesTests
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import XCTest
@testable import Recipes

class RecipeUrlTests: XCTestCase {
    
    func testTrendingRecipesUrl() {
        let url = URL.trendingRecipes
        XCTAssertEqual(url.absoluteString, "http://food2fork.com/api/search?key=15eb1d3ea05cbbe01cdc048ed0a63e4d&sort=t&count=10")
    }
    
    func testSearchRecipesUrl() {
        let searchKeyword = "search_keyword"
        let url = URL.searchRecipes(with: searchKeyword)
        XCTAssertEqual(url.absoluteString, "http://food2fork.com/api/search?key=15eb1d3ea05cbbe01cdc048ed0a63e4d&sort=r&q=\(searchKeyword)")
    }
    
    func testGetRecipeDetailUrl() {
        let recipeId = "mock_recipe_id"
        let url = URL.getRecipeDetail(with: recipeId)
        XCTAssertEqual(url.absoluteString, "http://food2fork.com/api/get?key=15eb1d3ea05cbbe01cdc048ed0a63e4d&rId=\(recipeId)")
    }
}
