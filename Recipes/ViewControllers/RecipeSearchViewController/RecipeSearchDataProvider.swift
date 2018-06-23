//
//  RecipeSearchDataProvider.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

protocol RecipeSearchDataProviderDelegate: class {
    
    /// Tell the delegate that data has been updated, it would be nice to update the UI
    func recipeSearchDataProviderDidUpdateData(_ recipeSearchDataProvider: RecipeSearchDataProvider)
}

final class RecipeSearchDataProvider {
    
    weak var delegate: RecipeSearchDataProviderDelegate?
    
    /// API service for making network requests
    private let apiService: APIService
    
    /// Recipe previews that should be shown on recipe search table view
    private var recipePreviews = [RecipePreview]()
    
    init(with apiService: APIService) {
        self.apiService = apiService
    }
  
    func numberOfRows() -> Int {
        return recipePreviews.count
    }
    
    func data(for indexPath: IndexPath) -> RecipePreview {
        guard indexPath.row < recipePreviews.count else {
            preconditionFailure("⚠️ Trying to retrieve out of boundary data")
        }
        return recipePreviews[indexPath.row]
    }
}

// MARK: - API service related
extension RecipeSearchDataProvider {
    
    /// Load trending recipes
    func loadTrendingRecipes() {
        apiService.load(.trendingRecipes) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let recipeSearchResponse):
                self.recipePreviews = recipeSearchResponse.recipes
                self.delegate?.recipeSearchDataProviderDidUpdateData(self)
            case .failure(let error):
                print("⚠️ \(#function) failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Search recipes 
    func searchRecipes(query: String) {
        apiService.load(.searchRecipes(with: query)) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let recipeSearchResponse):
                self.recipePreviews = recipeSearchResponse.recipes
                self.delegate?.recipeSearchDataProviderDidUpdateData(self)
            case .failure(let error):
                print("⚠️ \(#function) failed with error: \(error.localizedDescription)")
            }
        }
    }
}
