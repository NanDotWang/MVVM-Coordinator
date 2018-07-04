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
    func recipeSearchDataProvider(_ recipeSearchDataProvider: RecipeSearchDataProvider, didUpdateData data: [RecipePreview])
}

final class RecipeSearchDataProvider {
    
    weak var delegate: RecipeSearchDataProviderDelegate?
    
    /// API service for making network requests
    private let apiService: APIService
    
    private var topTrendingRecipes = [RecipePreview]()
    
    private var searchResultRecipes = [RecipePreview]()
    
    var isSearching: Bool = false {
        didSet {
            // Clear all search results if not in searching state
            if !isSearching {
                searchResultRecipes.isEmpty ? () : searchResultRecipes.removeAll()
            }
            delegate?.recipeSearchDataProvider(self, didUpdateData: isSearching ? searchResultRecipes : topTrendingRecipes)
        }
    }    
    
    init(with apiService: APIService) {
        self.apiService = apiService
    }
  
    func numberOfRows() -> Int {
        return isSearching ? searchResultRecipes.count : topTrendingRecipes.count
    }
    
    func data(for indexPath: IndexPath) -> RecipePreview {
        let recipes = isSearching ? searchResultRecipes : topTrendingRecipes
        return recipes[indexPath.row]
    }
    
    func clearSearchResults() {
        searchResultRecipes.isEmpty ? () : searchResultRecipes.removeAll()
        delegate?.recipeSearchDataProvider(self, didUpdateData: searchResultRecipes)
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
                self.topTrendingRecipes = recipeSearchResponse.recipes
                self.delegate?.recipeSearchDataProvider(self, didUpdateData: self.topTrendingRecipes)
            case .failure(let error):
                print("⚠️ \(#function) failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Search recipes 
    func searchRecipes(query: String) -> RequestToken {
        return apiService.load(.searchRecipes(with: query)) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let recipeSearchResponse):
                self.searchResultRecipes = recipeSearchResponse.recipes
                self.delegate?.recipeSearchDataProvider(self, didUpdateData: self.searchResultRecipes)
            case .failure(let error):
                print("⚠️ \(#function) failed with error: \(error.localizedDescription)")
            }
        }
    }
}
