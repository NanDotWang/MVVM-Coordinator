//
//  RecipeSearchResponse.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-22.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

struct RecipeSearchResponse: Codable {
    let count: Int
    let recipes: [RecipePreview]    
}
