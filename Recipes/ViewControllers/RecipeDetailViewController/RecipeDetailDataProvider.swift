//
//  RecipeDetailDataProvider.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

protocol RecipeDetailDataProviderDelegate: class {
    
    func RecipeDetailDataProviderDidUpdateData(_ recipeDetailDataProvider: RecipeDetailDataProvider)
}

final class RecipeDetailDataProvider {
    
    weak var delegate: RecipeDetailDataProviderDelegate?

    let apiService: APIService
    
    private let recipePreview: RecipePreview
    
    private var recipeDetail = RecipeDetail.empty

    init(with apiService: APIService, recipePreview: RecipePreview) {
        self.apiService = apiService
        self.recipePreview = recipePreview
    }
    
    func numberOfRows() -> Int {
        return recipeDetail.ingredients.count
    }
    
    func data(for indexPath: IndexPath) -> String {
        guard indexPath.row < recipeDetail.ingredients.count else {
            preconditionFailure("⚠️ Trying to retrieve out of boundary data")
        }
        return recipeDetail.ingredients[indexPath.row]
    }
    
    var recipeHeaderImageUrl: URL? {
        return URL(string: recipeDetail.image_url)
    }
    
    var publisherName: String {
        return recipeDetail.publisher
    }
    
    var socialRank: Double {
        return recipeDetail.social_rank
    }
    
    var instructionsUrl: URL? {
        return URL(string: recipeDetail.source_url)
    }
    
    var originalUrl: URL? {
        return URL(string: recipeDetail.f2f_url)
    }
    
    var recipeName: String {
        return recipeDetail.title
    }
}

// MARK: - API service related
extension RecipeDetailDataProvider {
    
    /// Load recipe detail
    func loadRecipeDetail() {
        apiService.load(.recipeDetail(with: recipePreview.recipe_id)) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let recipeDetailResponse):
                self.recipeDetail = recipeDetailResponse.recipe
                self.delegate?.RecipeDetailDataProviderDidUpdateData(self)
            case .failure(let error):
                print("⚠️ \(#function) failed with error: \(error.localizedDescription)")
            }
        }
    }
}
