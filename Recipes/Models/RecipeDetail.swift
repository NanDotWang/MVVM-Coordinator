//
//  RecipeDetail.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

struct RecipeDetail: Codable {
    let publisher: String
    let f2f_url: String
    let ingredients: [String]
    let source_url: String
    let recipe_id: String
    let image_url: String
    let social_rank: Double
    let publisher_url: String
    let title: String
}
