//
//  RecipeSearchCoordinator.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-22.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

final class RecipeSearchCoordinator: NSObject {
    
    private let apiService = APIService()
    
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: recipeSearchViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()
    
    private lazy var recipeSearchViewController: RecipeSearchViewController = {
        let dataProvider = RecipeSearchDataProvider(with: apiService)
        let recipeSearchViewController = RecipeSearchViewController(with: dataProvider)
        recipeSearchViewController.delegate = self
        return recipeSearchViewController
    }()
}

extension RecipeSearchCoordinator: RecipeSearchViewControllerDelegate {
    
    func recipeSearchViewController(_ recipeSearchViewController: RecipeSearchViewController, didSelectRecipe recipePreview: RecipePreview) {
        
        print(recipePreview)
    }
}
